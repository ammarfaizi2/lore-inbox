Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbTCNL6r>; Fri, 14 Mar 2003 06:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbTCNL6r>; Fri, 14 Mar 2003 06:58:47 -0500
Received: from dns2.seagha.com ([217.66.0.19]:23826 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id <S262977AbTCNL6p>;
	Fri, 14 Mar 2003 06:58:45 -0500
Posted-and-Mailed: no
Subject: Re: v2.5.32 - v2.5.64+ Locks at Boot with Athlon Machine
From: Karl Vogel <karl.vogel@seagha.com>
References: <5.1.0.14.0.20030312104635.022b1178@shrek>
Organization: SEAGHA cv
User-Agent: Xnews/5.04.25
To: linux-kernel@vger.kernel.org
Message-Id: <E18tnzg-0007Zf-00@relay-1.seagha.com>
Date: Fri, 14 Mar 2003 13:09:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Mar 2003, you wrote in linux.kernel:

>   I've tried versions 2.5.32, 2.5.59, 2.5.61, and 2.5.64, as well as
>   version 2.5.31 and earlier on my machine.  Every version from 2.5.32
>   and above locks up after printing: 
> 
>         Uncompressing Linux... Ok, booting the kernel.
> 
>   I've noticed there have been some significant changes in what I
>   understand of the boot process at this point, but I can't decipher
>   the assembly hardly at all well enough to try to investigate
>   further.  Is there any place that I can acquire a set of the 
>   separate, unrelated patches that happened between 2.5.31 (which
>   boots) and 2.5.32? I'm basically a trained monkey when it comes to
>   debugging this kind of thing, so I'm going to have to try the old
>   "back out a patch and see if it works" technique. 
> 
>   My config file is pretty bare-bones, I've tried with and without the
>   "mem=nopentium" and "noauto" kernel parameters (as dredged up via
>   Google).  I've also tried replacing setup.S from v2.5.31, this just
>   immediately reboots. 
> 
> Any help would be greatly appreciated,
> --Jim
> 

I'm having the same problem with 2.5.64 (haven't tried another dev kernel 
yet). The system boots, prints the

'Uncompressing Linux... Ok, booting the kernel.'

message and then locks up. After 2-3 seconds the capslock led turns off and 
then the system is totally locked, requiring a press of the reset button to 
reset the system (CTRL-ALT-DEL doesn't work). SysRq doesn't work either.

My system specs:
- AthlonXP 1700
- VIA KT266A chipset / 512Mb DDR ram
- normal keyboard (no USB) and PS/2 mouse
- GeForce4 Ti4600 videocard (kernel not compiled with framebuffer)
- 3 IDE UDMA harddisks, 1 IDE CD-RW attached

    
