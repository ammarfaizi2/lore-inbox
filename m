Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRDMWLq>; Fri, 13 Apr 2001 18:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132045AbRDMWL0>; Fri, 13 Apr 2001 18:11:26 -0400
Received: from denise.shiny.it ([194.20.232.1]:50310 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S132027AbRDMWLV>;
	Fri, 13 Apr 2001 18:11:21 -0400
Message-ID: <3AD779CB.ED7C1656@denise.shiny.it>
Date: Sat, 14 Apr 2001 00:12:28 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: I can eject a mounted CD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My fstab:

/dev/cdrom              /mnt/cdrom              iso9660
noauto,user,ro           0 0
/dev/cdrom              /mnt/cdmac              hfs    
noauto,user,ro           0 0

I insert an apple cd (hfs) and mount /mnt/cdmac
If I type eject /mnt/cdrom the cd momes out but
df shows it's still mounted:

/dev/sr0                667978    667978         0 100% /mnt/cdmac

It's funny it don't let me eject cdmac

[Giu@Jay Giu]$ eject /mnt/cdmac/
umount: /dev/sr0 is not in the fstab (and you are not root)
eject: unmount of `/dev/sr0' failed

Bye.
