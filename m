Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129870AbQK0QVl>; Mon, 27 Nov 2000 11:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129950AbQK0QVb>; Mon, 27 Nov 2000 11:21:31 -0500
Received: from mailx.planet-interkom.de ([195.182.114.81]:4615 "EHLO
        mail.vi-internet.de") by vger.kernel.org with ESMTP
        id <S129870AbQK0QVO>; Mon, 27 Nov 2000 11:21:14 -0500
From: Niels Happel <nhappel@planet-interkom.de>
Date: Mon, 27 Nov 2000 16:56:20 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Possible SCSI or ISOFS Bug in 2.4.0-test11
MIME-Version: 1.0
Message-Id: <00112716562000.01054@ws-20>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

first of all: I am new to the linux-kernel list, so I don't know wheather 
writing here is allowed for everybody or developers only.

Anyway, here it is:

Hardware (SCSI-only system):

Tekram 390 U2W (SYM53C8XX support compiled into the kernel)
IBM U2W SCSI disks
HP DAT SCSI Streamer
Pioneer SCSI DVD
Yamaha SCSI CD R/W

Using kernel 2.4.0-test10 and earlier everything works fine. 
Using 2.4.0-test11 with the same kernel configuration an error message 
occured while accessing one of the mounted SCSI CD-ROMs:
"kernel: _isofs_bmap: block < 0"
Mounting them works fine, accessing them gives that error message.
It can't be an SCSI CD-ROM hardware failure, because the error message 
occured at both drives (Pioneer and Yamaha) and it doesn't matter which 
CD-ROM I am using.


Any hints?


-- 
Many greetings, 
                    Niels!

nhappel@planet-interkom.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
