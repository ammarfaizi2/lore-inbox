Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbRE0UPh>; Sun, 27 May 2001 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbRE0UPS>; Sun, 27 May 2001 16:15:18 -0400
Received: from hamachi.synopsys.com ([204.176.20.26]:41692 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S262119AbRE0UPK>; Sun, 27 May 2001 16:15:10 -0400
Message-ID: <3B116039.AEAEEF69@Synopsys.COM>
Date: Sun, 27 May 2001 22:14:49 +0200
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chris Rankin <rankinc@pacbell.net>
Subject: Re: Overkeen CDROM disk-change messages
In-Reply-To: <200105271945.f4RJjxh00759@twopit.underworld>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe thats related to the problems with my CDROM drives (SCSI or 
IDE SCSI emulation). I cannot mount any CD with 2.4.5. kern.log says:

May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr2 at scsi2, channel 0, id 0, lun 0
May 26 15:31:17 bilbo kernel: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
May 26 15:31:17 bilbo kernel: Uniform CD-ROM driver Revision: 3.12
May 26 15:31:17 bilbo kernel: sr1: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
May 26 15:31:17 bilbo kernel: sr2: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
May 26 15:31:17 bilbo kernel: VFS: Disk change detected on device sr(11,1)
May 26 15:31:17 bilbo last message repeated 3 times
May 26 15:31:17 bilbo kernel: Device 0b:01 not ready.
May 26 15:31:17 bilbo kernel:  I/O error: dev 0b:01, sector 1024

Of course I did _not_ change the CD 4 times within 1 second.


Regards

Harri
