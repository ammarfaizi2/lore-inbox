Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSFASSR>; Sat, 1 Jun 2002 14:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSFASSQ>; Sat, 1 Jun 2002 14:18:16 -0400
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:61674
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S317024AbSFASSQ> convert rfc822-to-8bit; Sat, 1 Jun 2002 14:18:16 -0400
Subject: linux-2.4.19-pre9 and sym53c8xx problem
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1022954728.8107.15.camel@sector17.home.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Jun 2002 20:14:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.4.19-pre8 cdrecord does not work anymore. It worked with -pre6,
-pre7 i've missed, don't know about this one. Maybe i'll try it after
this mail.

[root@sector17:/proc/scsi]# uname -a
Linux sector17.home.at 2.4.19-pre9 #2 SMP Sat Jun 1 19:31:25 CEST 2002 i686 unknown
[root@sector17:/proc/scsi]# cdrecord -scanbus
Cdrecord 1.11a08 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open SCSI driver.
cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are root.


Jun  1 19:38:28 (none) kernel: SCSI subsystem driver Revision: 1.00
Jun  1 19:38:28 (none) kernel: sym53c8xx: at PCI bus 0, device 9, function 0
Jun  1 19:38:28 (none) kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Jun  1 19:38:28 (none) kernel: sym53c8xx: 53c810a detected with Symbios NVRAM
Jun  1 19:38:28 (none) kernel: sym53c810a-0: rev 0x23 on pci bus 0 device 9 function 0 irq 5
Jun  1 19:38:28 (none) kernel: sym53c810a-0: Symbios format NVRAM, ID 7, Fast-10, Parity Checking
Jun  1 19:38:28 (none) kernel: sym53c810a-0: restart (scsi reset).
Jun  1 19:38:28 (none) kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Jun  1 19:38:33 (none) kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01 
Jun  1 19:38:33 (none) kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02

Any known issues?

Regards.

