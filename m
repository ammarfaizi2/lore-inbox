Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWJVPRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJVPRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWJVPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:17:47 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:23057 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1750796AbWJVPRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:17:46 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061022122355.GC3502@stusta.de>
	<200610221046.51464.gene.heskett@verizon.net>
Date: Sun, 22 Oct 2006 08:17:36 -0700
In-Reply-To: <200610221046.51464.gene.heskett@verizon.net> (message from Gene
	Heskett on Sun, 22 Oct 2006 10:46:51 -0400)
Message-ID: <87r6x09y7j.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> On Sunday 22 October 2006 08:23, Adrian Bunk wrote:
>>This email lists some known unfixed regressions in 2.6.19-rc2 compared
>>to 2.6.18 that are not yet fixed Linus' tree.
>>
> [...]
>>
>>Subject    : unable to rip cd
>>References : http://lkml.org/lkml/2006/10/13/100
>>Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
>>Status     : unknown
>
> FWIW Alex, I just ripped track 2 of a Trace Adkins CD using grip and 
> cdparanoia, then listened to the track in mplayer, while running 
> 2.6.19-rc2.  No problem at all.  This is however, an older FC2 system, so 
> I'd be inclined to point the finger at cdparanoia's latest version.  Mine 
> hasn't been updated for quite a while.  I have these installed:
>
> cdparanoia-alpha9.8-20.1
> cdparanoia-libs-alpha9.8-20.1
> cdparanoia-devel-alpha9.8-20.1

the system doesn't lock up all the time, but every time i start ripping
i get this in syslog:

Oct 22 08:08:16 trinculo kernel: hdc: write_intr: wrong transfer direction!

which didn't use to happen before 2.6.19-rc2 (the lockups did).
anyway, i just gave it another try, grip wasn't able to rip the cd but
i was able to eject the cd from the drive and then abort execution. i
am using cdparanoia that came with grip, and this is a very old
version (2.96, the last before they switched to gnome). i also tried
with the recent version of cdparanoia but the same thing happens.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
