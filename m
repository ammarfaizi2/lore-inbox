Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132211AbQKXLQU>; Fri, 24 Nov 2000 06:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131736AbQKXLQL>; Fri, 24 Nov 2000 06:16:11 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:39685 "EHLO
        mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
        id <S129280AbQKXLQE>; Fri, 24 Nov 2000 06:16:04 -0500
Date: Fri, 24 Nov 2000 11:44:20 +0000
From: Heinz.Mauelshagen@t-online.de (Heinz J. Mauelshagen)
To: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: *** ANNOUNCEMENT *** LVM 0.8.1 and LVM 0.9 available at www.sistina.com
Message-ID: <20001124114420.D9801@srv.t-online.de>
Reply-To: Mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to technical problems this might not have made it through...
Sorry in advance if you get it twice.


Hi all,

Linux Logical Volume Manager 0.8.1 (this is 0.8final plus patches)
and 0.9 are available for download at www.sistina.com.

Please see further information below, test it and help us
to make an even better LVM for Linux :-)


Regards,
Heinz      -- The LVM guy --




The Logical Volume Manager (LVM) is a subsystem for online disk storage
management which has become a de-facto standard for storage management
under Linux.

LVM 0.8.1 update to 0.8final:
-----------------------------
Supported on:
   - Linux 2.2.17
   - Linux 2.4.0-test10 (and previous 2.4.0 test kernels)

New features:
   - Enhance pvmove(8) to operate on single physical volumes
   - Added support for multiple ext2 resize commands via e2fsadm(8)
   - Changed device specials to belong to group "disk"
     to accomodate backup software
   - Initial support for DEVFS

Bug Fixes:
     - LV on disk metadata offset faults
     - Housekeeping for the metadata backup history file
     - lvdisplay(8) and pvdisplay(8) option -c and -v handling


LVM 0.9:
--------
Supported on:
   - Linux 2.4.0-test10 (and previous 2.4.0 test kernels)

New Features:
   - Persistent snapshots for logical volumes
   - Resizable snapshot logical volumes
   - API to request the usage rate of a snapshot logical volume
   - Integration with VFS to consistently mount ReiserFS filesystems
     on snapshots (VFS patch necessary)
   - Physical Volume and Volume Group UUID support
   - lv*(8) commands now use the Default Volume Group specifed in environment
     variable LVM_VG_NAME
   - A /proc/lvm/ directory hierarchy for use in parsing VGDA information
   - Initial support for DEVFS

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Bartningstr. 12
www.sistina.com                                   64289 Darmstadt
                                                  Germany
Mauelshagen@Sistina.com                           +49 6151 7103 86
                                                       FAX 7103 96
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
