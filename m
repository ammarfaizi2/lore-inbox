Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTBJWRw>; Mon, 10 Feb 2003 17:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTBJWRv>; Mon, 10 Feb 2003 17:17:51 -0500
Received: from [63.150.239.32] ([63.150.239.32]:26559 "HELO
	cortechs05.cortechs.net") by vger.kernel.org with SMTP
	id <S265333AbTBJWRk> convert rfc822-to-8bit; Mon, 10 Feb 2003 17:17:40 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rudolph Pienaar <rudolph@nmr.mgh.harvard.edu>
Organization: Massachusetts General Hospital
To: linux-kernel@vger.kernel.org
Subject: Problems booting without attached PS/2 mouse
Date: Mon, 10 Feb 2003 17:27:23 -0500
User-Agent: KMail/1.4.3
Cc: Rudolph Pienaar <rudolph@nmr.mgh.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302101727.23600.rudolph@nmr.mgh.harvard.edu>
X-OriginalArrivalTime: 10 Feb 2003 22:31:46.0968 (UTC) FILETIME=[32366980:01C2D154]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello  all -

First off, I am not a kernel developer, however I have tried to make sure 
(google searches, manufacturer phone calls, newsgroup searches) IMHO that my 
problem is kernel related (or some combination of kernel/motherboard) before 
posting. 

My Problem: Linux (various kernels, distributions) seems to freeze while 
booting on my hardware after displaying "Uncompressing Linux... Ok, booting 
the kernel" iff I do not have a PS/2 mouse plugged in. Plug the PS/2 mouse 
in, and booting is no problem. Unplug the PS/2 mouse just as the bulk of 
kernel boot messages display, no problem. But reboot without a PS/2 mouse, 
and the system simply freezes after the above text message.

I am currently running a stock RedHat 8.0 release on a Shuttle XPC SK41G. The 
CPU is an AMD Athlon XP 2400. Motherboard has a VIA KM266 chipset. I 
discovered some mention of the same boot freezing problem while searching for 
Shuttle XPC specific postings. I discovered recently that a co-worker 
experiences the same problems with a stock RedHat 7.3 installation on his 
Dual Xeon 2.5GHz box with a SuperMicron P4DC motherboard - boot freezes if 
there is no PS/2 mouse.

The "no-boot without plugged in PS/2 mouse" is repeatable across Mandrake 9.0, 
custom builds of the RedHat 8.0 2.4.18-14 kernel, as well as a stock 2.4.20 
kernel on my Shuttle XPC box.

Given the different hardward configurations, different distributions, and 
different kernels attempted -- all susceptible to this freezing problem led 
me to believe that this might be a kernel problem.

Any useful suggestions would be much appreciated.

Regards
--R

PS: If possible, please CC any responses to me personally.

-- 
Rudolph Pienaar, D.Eng / email: rudolph@nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street, Charlestown, MA 02129 USA
(w) 617-241-9588x17

