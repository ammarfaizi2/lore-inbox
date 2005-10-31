Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVJaJfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVJaJfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVJaJfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:35:01 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:47832 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932355AbVJaJfB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:35:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mJ/syYWZ7bVpzxryzP1KSgyJqmw3YhSe49fGd+g/U/ttkZi7n3zGTVhtD3A66IItaL1c9HBTgEPFECnE0Lf46mai0iGWL/93xCkIUTJtRi6BM3Zjbl7N8A0x8Fbf6QFhVealX7OBIBfLKvAMFeovSuZW20fvDcu6lhb9V9kvU+E=
Message-ID: <460afdfa0510310134n1742e1fk95116b85df485dfc@mail.gmail.com>
Date: Mon, 31 Oct 2005 10:34:59 +0100
From: Luca <luca.foppiano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sata problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
 I have abit aa8xe with intel  925Xe chipset. I have kernel 2.6.14 and
I have this error:

ata1: SATA max UDMA/133 cmd 0xFA00 ctl 0xF902 bmdma 0xF600 irq 193
ata2: SATA max UDMA/133 cmd 0xF800 ctl 0xF702 bmdma 0xF608 irq 193
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:207f
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xF807
ata2: disabling port

why I return this error? Sata work with enchanced mode. If I do:

pj@crumble:~$ sudo hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   4152 MB in  2.00 seconds = 2075.28 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device
 Timing buffered disk reads:  164 MB in  3.02 seconds =  54.31 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate
ioctl for device

I return an error. Is critical? When kernel will support my controller?
tnks very much
bye
Luca
