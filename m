Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKOSjW>; Wed, 15 Nov 2000 13:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbQKOSjC>; Wed, 15 Nov 2000 13:39:02 -0500
Received: from pppl40.bunt.com ([195.178.11.40]:27652 "EHLO dragon.flyn.org")
	by vger.kernel.org with ESMTP id <S129199AbQKOSiq>;
	Wed, 15 Nov 2000 13:38:46 -0500
Date: Wed, 15 Nov 2000 18:59:58 +0100
From: "W. Michael Petullo" <mike@flyn.org>
To: linux-kernel@vger.kernel.org
Subject: EJECT ioctl fails on empty SCSI CD-ROM
Message-ID: <20001115185958.A5072@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux dragon.flyn.org 2.4.0-test11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently using the CDROMEJECT ioctl with kernel 2.4-testX fails on
a SCSI CD-ROM that does not have a disc in it.  The errno returned
corresponds to the string ``No such file or directory.''

The Linux CD-ROM Standard states that CDROMEJECT opens the drive tray.
It does not mention any prerequisite such as media being present.

Is this the expected behavior?  If so, I am curious to hear the rationale
behind it.

Thanks!

-- 
W. Michael Petullo

:wq
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
