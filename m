Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270363AbTGVLVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270796AbTGVLVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:21:10 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:21482 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S270363AbTGVLVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:21:08 -0400
Message-ID: <3F1D21A3.30504@blue-labs.org>
Date: Tue, 22 Jul 2003 07:36:03 -0400
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCQ problems in 2.6.0-test1: the summary
References: <3F19C838.8040301@cornell.edu> <20030721123334.GF10781@suse.de> <3F1C1326.5080804@blue-labs.org> <3F1C1079.7060103@cornell.edu>
In-Reply-To: <3F1C1079.7060103@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Gyurdiev wrote:

> > Note, reiserfsck never indicates any problems were found or fixed 
> but the problems are none-the-less fixed.  (reiser guys: reiserfsck 
> --fix-fixable always results in "--fix-fixable ignored")
>
> I think it does that when the root fs is mounted - not sure.
> You should fsck from a different root.


Right, let me just add a harddrive to my notebook ;)

> Jul 19 10:55:31 james hdc: invalidating tag queue (0 commands)
>
>> Jul 19 10:55:41 james ide_tcq_intr_timeout: timeout waiting for 
>> completion interrupt
>
>
> Yes - that's in my original email.
>
>> and further disk access causes D state.  I upgraded this machine to 
>> 2.6.0-test1 and now it's having fits with apic or acpi but that's 
>> another email.  And a side note, if I have TCQ compiled in w/ 
>> 2.6.0-test1, the kernel barfs a long 40+ function OOPS on bootup.
>
>
> Jens's patch in my email should fix that.
> However, TCQ seems rather broken to me right now (or maybe it's just my
> machine) - so I'd be careful with it.

noted.

I'm waiting for the next batch of updates, 2.6.0-test1 seems to be quite 
broken in several places for several of my machines. :/

david

