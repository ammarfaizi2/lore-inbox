Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUA2MvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 07:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUA2MvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 07:51:08 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:13725 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265947AbUA2MvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 07:51:06 -0500
Message-ID: <401901B5.5080306@samwel.tk>
Date: Thu, 29 Jan 2004 13:51:01 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Micha Feigin <michf@post.tau.ac.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
 disks? (to allow spin-downs)
References: <Pine.LNX.3.96.1040127133932.11664B-100000@gatekeeper.tmr.com> <4016B3F0.1060804@samwel.tk> <4017B98C.2040603@isg.de> <20040128230609.GE3975@luna.mooo.com>
In-Reply-To: <20040128230609.GE3975@luna.mooo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin wrote:
>>My curiosity isn't completely gone, though, so maybe one day I'll try to
>>find out who-is-trying-to-read-what, "find -atime ..." didn't reveal the 
>>secret
>>yet.
> 
> It might help you find the culprit. There is a laptopmode patch
> for 2.6. If you echo a number n larger then 1 into
> /proc/sys/vm/laptopmode it will dump the first n disk accesses to the
> console (The docs that come with the patch have the complete
> description).

This was true in the first version (for /proc/sys/vm/block_dump, not 
laptop_mode), however, this approach was then shot down in favor of a 
simple on/off flag.

--Bart
