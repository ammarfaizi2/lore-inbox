Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268418AbTAMXZZ>; Mon, 13 Jan 2003 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTAMXZZ>; Mon, 13 Jan 2003 18:25:25 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:8901 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S268418AbTAMXZW> convert rfc822-to-8bit; Mon, 13 Jan 2003 18:25:22 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.20 (-aa1): System hang during second (?) /dev/fd0 access
Date: Tue, 14 Jan 2003 00:33:59 +0100
User-Agent: KMail/1.5
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200301140033.59138.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

during or after the second (?) /dev/fd0 (floppy) access (mdir/mcopy/cp) or 
when I do a "sync" during the first access the whole system locks up. This 
only take place when the system is running in the third or fifth runlevel. 
When I start into runlevel one (init 1) it doesn't happen. Nothing in the 
logs.

System:
dual Athlon MP 1900+
MSI K7D Master-L (aka MS-6501, Rev 1.0, AMD 768MPX)
Linux 2.4.20 (-aa1) SMP
ACPI with or without AMD76x_pm module loaded

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
