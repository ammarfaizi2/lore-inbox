Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUKCUTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUKCUTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbUKCUTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:19:01 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:6371 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261851AbUKCUSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:18:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 15:18:50 -0500
User-Agent: KMail/1.7
Cc: DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031353.39468.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD>
In-Reply-To: <20041103192648.GA23274@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411031518.50358.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 14:18:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 14:26, DervishD wrote:
>    Hi Gene :)
>
> * Gene Heskett <gene.heskett@verizon.net> dixit:
>> >    Then the children are reparented to 'init' and 'init' gets
>> > rid of them. That's the way UNIX behaves.
>>
>> Unforch, I've *never* had it work that way.  Any dead process I've
>> ever had while running linux has only been disposable by a reboot.
>
>    Well, you know, shit happens... Anyway, could you define 'dead'?
>Because if you're talking about zombies whose parent dies, they're
>killable easily: just wait until init reaps them (usually in less
>than 5 minutes since they dead). If you are talking about zombies
> who has their parent alive, then it's a bug in the application, not
> the kernel. In fact I wouldn't like if the kernel reaps my children
> before I do, just in case I want to do something.
>
>    If you're talking about unkillable processes (those stuck in
>disk-sleep state), you're right: only rebooting can kill them
>(although sometimes they go out of D state and die normally). Bad
>luck for you if any dead process you've ever had while running linux
>has been of this kind :(
>
>    Raúl Núñez de Arenas Coronado

That seems to be the only kind of dead processes I get, and thats not 
too often.  Booted to 2.6.10-rc1-bk11 now, its all working just fine 
except for on messydos patch that finally must have made it into the 
tree.

As it appears I do not have a prayer of convincing folks otherwise 
about this issue, I suggest we let this thread die a well deserved 
death till it bites me or someone else again.  I'll summerize that 
os9/nitros9 handles this situation effortlessly and flawlessly, and I 
expected a 150x more sophisticated os to do likewise.  My mistake.  
OTOH, its one hell of a versatile os IMNSHO.  I'm not going away just 
because it bites me occasionally.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
