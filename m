Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUI1LBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUI1LBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 07:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUI1LBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 07:01:13 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:52611 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264246AbUI1LBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 07:01:08 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Tue, 28 Sep 2004 07:01:06 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Matt Heler <lkml@lpbproductions.com>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409280626.50167.gene.heskett@verizon.net> <20040928103324.GA21050@elte.hu>
In-Reply-To: <20040928103324.GA21050@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409280701.06932.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.46.219] at Tue, 28 Sep 2004 06:01:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 06:33, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> >what i use is serial logging to another machine. A digital camera
>> > is fine too, if the problem area is still visible on the screen.
>> > (Netconsole is useful too for other type of hangs but it's not
>> > active at such an early stage yet.)
>> >
>> > Ingo
>>
>> Unforch, I don't have a spare seriel port Ingo.  One is running my
>> x10
>
>fortunately with the patch applied your box works now (so does mine)
> so the bug appears to be fixed.

I just built a kernel with that latest stack-fix patch in it too, but 
haven't rebooted to it yet.  I read that as being moderately 
important in some cases although I don't think I've encountered that 
particular case yet.  Was this in fact a good idea for me?

>early-bootup debugging was never easy, and breakage there doesnt
> happen all that often. Hopefully this was the last one related to
> remove-BKL.
>
>(If such a early-bootup lockup happens in the future then you sure
> could temporarily unplug the ups serial connection and use that as
> the serial console - for the narrow and temporary purpose of
> debugging that boot-time hang.)

That would I assume need a null modem cable, and what do I run on the 
firewall?  Minicom?  Or is there something better that can just grab 
and log without being interactive?  Its a rh7.3 box with a 2.4.18 era 
kernel.  I'd update that, but its not broken. :)
>
> Ingo

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
