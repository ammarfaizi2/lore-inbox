Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTDLO4v (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTDLO4v (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 10:56:51 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:3456 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S263285AbTDLO4u convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 10:56:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>,
       linux-kernel@vger.kernel.org
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Sat, 12 Apr 2003 16:08:33 +0100
User-Agent: KMail/1.4.3
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
In-Reply-To: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304121608.33357.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 Apr 2003 1:10 pm, Frank Van Damme wrote:
> Hello,
>
> I have stability problems with my computer when using OpenGl applications.
> First of all, this is the hardware I am using that may be responsible:
>
> - Motherboard: Soltek sl-75fvr with a kt400 chipset
> - Cpu: Athlon Xp 2000+
> - Video card: Ati radeon 8500 retail, 64 MB ddr.
>
> Software I am using:
>
> - distribution: Debian Sid
> - Xfree86: version 4.3, packaged in Debian packages by Daniel Stone
> <http://capricorn.woot.net/~daniels/sid/i386/>
> - Linux kernel: version 2.4.21-pre5-ac3
> - Quake3 + urban terror, tuxracer (old version 0.6), xmms openGL plugins.
>
> The symptoms are as follows. Linux boots fine, the "radeon" kernel module
> inserts with no errors. X also starts without problems and runs stably in
> day-to-day work and during cpu-intensive tasks such as compiling. However,
> if Istart running OpenGL applications (games) (quake,tuxracer or whatever)
> themachine will freeze in anything from 2 minutes to an hour. The last
> frame remains on the screen, but I can still login over ssh and reboot.
> The drivers of this card are only stable since the latest XFree86 release,
> butsince I had hours of crashless fun with that card on another motherboard
> (anepox 7kxa which is now broken), and since the agp features of the kt400
> chipsetare only supported since kernel version 2.4.21-pre1, I supposed that
> was thecause of my problems.
>
> Unfortunately I am unable to provide any useful error messages. The kernel
> doesnot oops or panic, there are no messages on stdout/stderr, X's log file
> does notshow anything, idem for syslog. I find only positive messages in
> dmesg:
> Mar 30 23:07:34 dionysos kernel: Linux agpgart interface v0.99 (c) Jeff
> HartmannMar 30 23:07:34 dionysos kernel: agpgart: Maximum main memory to
> use for agp memory: 203MMar 30 23:07:34 dionysos kernel: agpgart: Detected
> Via Apollo Pro KT400 chipsetMar 30 23:07:34 dionysos kernel: agpgart: AGP
> aperture is 64M @ 0xe0000000
>
> Mar 30 23:07:44 dionysos kernel: [drm] AGP 0.99 on VIA Apollo KT400 @
> 0xe000000064MBMar 30 23:07:44 dionysos kernel: [drm] Initialized radeon
> 1.7.0 20020828 on minor 0Mar 30 23:08:02 dionysos kernel: [drm] Loading
> R200 Microcode
>
> If there is anything I overlooked, further info I can provide, let me know.
>
> Thanks in advance,
>
> Frank Van Damme.

I'm running a KT400 based board (MSI KT4 Ultra) with a GeForce 4 Ti4200 (agp 
4x) on a custom compiled Mandrake 2.4.21 kernel.
I regularly play games such as Unreal Tournament / UT 2003 and Neverwinter 
Nights and I have to say that stability and performance is excelent.

I'm running Mandrake 9.0 which includes X 4.2.1, along with the latest nVidia 
binary drivers.

I certainly don't see any of the kind of application/X crash you are 
reporting. In fact, I've played NWN for most of a day with nothing going 
wrong that can't be attributed to the beta status of the game (the game 
doesn't crash, I just get some graphical glitches which are fixed by 
reloading a saved game).

If I can be of any more assistance, shout.

Mark Watts.



