Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaMuo>; Sun, 31 Dec 2000 07:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaMue>; Sun, 31 Dec 2000 07:50:34 -0500
Received: from AGrenoble-101-1-1-84.abo.wanadoo.fr ([193.251.23.84]:51953 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S129324AbQLaMuV>;
	Sun, 31 Dec 2000 07:50:21 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 test13-pre7 still causes CDROM ioctl errors
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Sun, 31 Dec 2000 13:19:47 +0100
Message-ID: <1344.978265187@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had sent the following report a week ago:

--------------------------
Since I've installed 2.4.0 test13-pre4, I see the following errors
in my log:

	sr0: CDROM (ioctl) reports ILLEGAL REQUEST.

and xmcd reports:

	CD audio: ioctl error on /dev/scd0: cmd=CDROMVOLCTRL errno=95

This was working fine with 2.4.0 test12-pre5, which was the previous
kernel I was using.
-------------------------

Well, I installed 2.4.0 test13-pre7 and I still have the same error.

My CDROM driver is SCSI, connected to a Tekram DC390.  I use
the am53c974 driver.

Something must have changed in this driver since 2.4.0 test12-pre5 which
broke the ioctl() handling routine.

Raphael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
