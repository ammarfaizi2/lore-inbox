Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293184AbSBWTJd>; Sat, 23 Feb 2002 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSBWTJV>; Sat, 23 Feb 2002 14:09:21 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:33951 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S293184AbSBWTJJ>; Sat, 23 Feb 2002 14:09:09 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Hang on floppy access, patched 2.4.18-rc[34]
Date: Sat, 23 Feb 2002 20:08:52 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
        Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200202232008.52370.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
>Hi.
>
> My system is locking up when trying to access the floppy drive.
> The mount or mkfs command just get stuck, no response to ctrl-c.
> Kernel is 2.4.18-rc3 with vm-25, sched-O1, read-latency, mini-lowlat,
> irqrate-A1. But is also hangs on rc4 without irqrate-A1.
> Decoded output from SysRQ-P follows:

How did you get the SysRQ-P output?
Didn't it lock up "hard"?

I use a similar kernel for several weeks and it lock up "hard" during "make 
zlilo" (always) or "make bzImage" (from time to time) ;-(
I have to-do several sync commands form another shell to build a bootable 
kernel. But "make modules modules_install" works always smooth.
No hangs during "normal" use.

Latest kernel is:
Linux version 2.4.18-pre8-K3-VM-24-preempt-lock (root@SunWave1) (gcc version 
2.95.3 20010315 (SuSE)) #1 Mit Feb 13 23:15:44 CET 2002
plus
waitq-2.4.17-mainline-1
bootmem-2.4.17-pre6
read-latency-2
latest ReiserFS stuff

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

