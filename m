Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbTGUR6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbTGUR5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:57:38 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:38897 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270653AbTGUR41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:56:27 -0400
Message-ID: <3F1C1079.7060103@cornell.edu>
Date: Mon, 21 Jul 2003 12:10:33 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ford <david+powerix@blue-labs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCQ problems in 2.6.0-test1: the summary
References: <3F19C838.8040301@cornell.edu> <20030721123334.GF10781@suse.de> <3F1C1326.5080804@blue-labs.org>
In-Reply-To: <3F1C1326.5080804@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note, reiserfsck never indicates any problems were found or fixed but 
> the problems are none-the-less fixed.  (reiser guys: reiserfsck 
> --fix-fixable always results in "--fix-fixable ignored")

I think it does that when the root fs is mounted - not sure.
You should fsck from a different root.


> Jul 19 10:55:31 james hdc: invalidating tag queue (0 commands)
> Jul 19 10:55:41 james ide_tcq_intr_timeout: timeout waiting for 
> completion interrupt

Yes - that's in my original email.

> and further disk access causes D state.  I upgraded this machine to 
> 2.6.0-test1 and now it's having fits with apic or acpi but that's 
> another email.  And a side note, if I have TCQ compiled in w/ 
> 2.6.0-test1, the kernel barfs a long 40+ function OOPS on bootup.

Jens's patch in my email should fix that.
However, TCQ seems rather broken to me right now (or maybe it's just my
machine) - so I'd be careful with it.




