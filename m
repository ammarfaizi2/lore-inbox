Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRBJPDS>; Sat, 10 Feb 2001 10:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131469AbRBJPC7>; Sat, 10 Feb 2001 10:02:59 -0500
Received: from front3.grolier.fr ([194.158.96.53]:59101 "EHLO
	front3.grolier.fr") by vger.kernel.org with ESMTP
	id <S131450AbRBJPCu> convert rfc822-to-8bit; Sat, 10 Feb 2001 10:02:50 -0500
Date: Sat, 10 Feb 2001 15:01:50 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Linux <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: SYM-2 / SYM-1 / NCR-3 drivers UPdates
Message-ID: <Pine.LNX.4.10.10102101443540.1796-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated drivers for SYMBIOS 53C[8XX|1010] chips are available from 
the ftp.tux.org site.

sym53c8xx-1.7.3-pre1 + ncr53c8xx-3.4.3-pre1
-------------------------------------------
URL (entered by hand):
ftp.tux.org://roudier/drivers/linux/stable/sym-1.7.3-ncr-3.4.3-pre1.tar.gz

sym-2.1.6
---------
URL (entered by foot :))
ftp.tux.org://roudier/drivers/portable/sym-2.1.6-20010207.tar.gz

The former is an update for the driver bundle currently in 2.2 and 2.4.
The latter is the portable sym driver that for now supports Linux and 
FreeBSD.

Stock sym/ncr drivers in both 2.2 and 2.4 are more than 6 months old and
need to be updated. My plan is to leave kernel maintainers the choice
between sym-1/ncr-3 and sym-2. Btw, sym-2 is anyway candidate for 2.5.

The both (tri?) drivers do call pci_enable_device() prior to looking 
into the pcidev structure. Donnot colour me happy of that, but given that
it is not me but kernel maintainers that will be bashed if this breaks
firmware RAID, I didn't see any problem for this change. :-)

If some additionnal testing could be performed this week-end by courageous
Linux users, this will avoid some noise once sent to kernel maintainers,
if I missed something important in the updates.

  Gérard.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
