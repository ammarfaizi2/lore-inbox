Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSFUE26>; Fri, 21 Jun 2002 00:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFUE25>; Fri, 21 Jun 2002 00:28:57 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:52723 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S316213AbSFUE25>; Fri, 21 Jun 2002 00:28:57 -0400
Date: Thu, 20 Jun 2002 23:28:57 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: CDROM (DVDROM) cd-rom problem
Message-ID: <20020620232857.A7249@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  When I'm mounting and reading CD-ROMs, I get the following
  error in the syslog:

Jun 20 23:23:28 jakob kernel: hdc: packet command error: status=0x51 [ drive ready,seek complete,error] 
Jun 20 23:23:28 jakob kernel: hdc: packet command error: error=0x50
Jun 20 23:23:28 jakob kernel: ATAPI device hdc:
Jun 20 23:23:28 jakob kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 20 23:23:28 jakob kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
Jun 20 23:23:28 jakob kernel:   The failed "Request Sense" packet command was: 
Jun 20 23:23:28 jakob kernel:   "03 00 00 00 12 00 00 00 00 00 00 00 "
Jun 20 23:23:28 jakob kernel:   Error in command packet byte 8 bit 0
Jun 20 23:23:28 jakob kernel: VFS: Disk change detected on device ide1(22,0)
Jun 20 23:26:26 jakob kernel: hdc: packet command error: status=0x51 [ drive ready,seek complete,error] 
Jun 20 23:26:26 jakob kernel: hdc: packet command error: error=0x50
Jun 20 23:26:26 jakob kernel: ATAPI device hdc:
Jun 20 23:26:26 jakob kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 20 23:26:26 jakob kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
Jun 20 23:26:26 jakob kernel:   The failed "Request Sense" packet command was: 
Jun 20 23:26:26 jakob kernel:   "03 00 00 00 12 00 00 00 00 00 00 00 "
Jun 20 23:26:26 jakob kernel:   Error in command packet byte 8 bit 0
Jun 20 23:26:26 jakob kernel: VFS: Disk change detected on device ide1(22,0)
Jun 20 23:27:00 jakob kernel: hdc: packet command error: status=0x51 [ drive ready,seek complete,error] 
Jun 20 23:27:00 jakob kernel: hdc: packet command error: error=0x50
Jun 20 23:27:00 jakob kernel: ATAPI device hdc:
Jun 20 23:27:00 jakob kernel:   Error: Illegal request -- (Sense key=0x05)
Jun 20 23:27:00 jakob kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
Jun 20 23:27:00 jakob kernel:   The failed "Request Sense" packet command was: 
Jun 20 23:27:00 jakob kernel:   "03 00 00 00 12 00 00 00 00 00 00 00 "
Jun 20 23:27:00 jakob kernel:   Error in command packet byte 8 bit 0
Jun 20 23:27:00 jakob kernel: VFS: Disk change detected on device ide1(22,0)

On booting, I get the following:
hdc: TOSHIBA DVD-ROM SD-M1102, ATAPI CD/DVD-ROM drive
[...]
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdc: packet command error: status=0x51 [ drive ready,seek complete,error] 
hdc: packet command error: error=0x50
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Request Sense" packet command was: 
  "03 00 00 00 12 00 00 00 00 00 00 00 "
  Error in command packet byte 8 bit 0


Anyone know what's going on with this?
Kernel is 2.5.24; it built beautifully for me.
Thanks!

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
"[...]this, they say, cost about $40 too much, and about 20,000 Iowans 
 bought [Windows] 98.  Which gives us a tab of $800,000, i.e. the
 equivalent of a rounding error in Redmond's vast war chest." -The Register
