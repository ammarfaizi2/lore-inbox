Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTDLL7U (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 07:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTDLL7U (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 07:59:20 -0400
Received: from anvers-smtp.planetinternet.be ([195.95.30.152]:24843 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id S263245AbTDLL7T (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 07:59:19 -0400
From: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
To: linux-kernel@vger.kernel.org
Subject: stabilty problems using opengl on kt400 based system
Date: Sat, 12 Apr 2003 14:10:58 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have stability problems with my computer when using OpenGl applications. 
First of all, this is the hardware I am using that may be responsible:

- Motherboard: Soltek sl-75fvr with a kt400 chipset
- Cpu: Athlon Xp 2000+
- Video card: Ati radeon 8500 retail, 64 MB ddr.

Software I am using:

- distribution: Debian Sid
- Xfree86: version 4.3, packaged in Debian packages by Daniel Stone
<http://capricorn.woot.net/~daniels/sid/i386/>
- Linux kernel: version 2.4.21-pre5-ac3
- Quake3 + urban terror, tuxracer (old version 0.6), xmms openGL plugins.

The symptoms are as follows. Linux boots fine, the "radeon" kernel module
inserts with no errors. X also starts without problems and runs stably in
day-to-day work and during cpu-intensive tasks such as compiling. However, 
if Istart running OpenGL applications (games) (quake,tuxracer or whatever) 
themachine will freeze in anything from 2 minutes to an hour. The last frame
remains on the screen, but I can still login over ssh and reboot.
The drivers of this card are only stable since the latest XFree86 release, 
butsince I had hours of crashless fun with that card on another motherboard 
(anepox 7kxa which is now broken), and since the agp features of the kt400 
chipsetare only supported since kernel version 2.4.21-pre1, I supposed that 
was thecause of my problems.

Unfortunately I am unable to provide any useful error messages. The kernel 
doesnot oops or panic, there are no messages on stdout/stderr, X's log file 
does notshow anything, idem for syslog. I find only positive messages in 
dmesg:
Mar 30 23:07:34 dionysos kernel: Linux agpgart interface v0.99 (c) Jeff 
HartmannMar 30 23:07:34 dionysos kernel: agpgart: Maximum main memory to use 
for agp memory: 203MMar 30 23:07:34 dionysos kernel: agpgart: Detected Via 
Apollo Pro KT400 chipsetMar 30 23:07:34 dionysos kernel: agpgart: AGP 
aperture is 64M @ 0xe0000000

Mar 30 23:07:44 dionysos kernel: [drm] AGP 0.99 on VIA Apollo KT400 @ 
0xe000000064MBMar 30 23:07:44 dionysos kernel: [drm] Initialized radeon 
1.7.0 20020828 on minor 0Mar 30 23:08:02 dionysos kernel: [drm] Loading R200 
Microcode

If there is anything I overlooked, further info I can provide, let me know.

Thanks in advance,

Frank Van Damme.

-- 
Frank Van Damme    | "Saying 8MB of RAM doesn't do as much anymore is
http://www.        | like saying a gallon of water holds more than it
openstandaarden.be | did in 1988."                    --George Adkins

