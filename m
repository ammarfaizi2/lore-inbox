Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291216AbSAaS2K>; Thu, 31 Jan 2002 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291217AbSAaS2A>; Thu, 31 Jan 2002 13:28:00 -0500
Received: from dwests3.datawest.net ([206.27.129.9]:26379 "EHLO
	dwests3.datawest.net") by vger.kernel.org with ESMTP
	id <S291216AbSAaS1r>; Thu, 31 Jan 2002 13:27:47 -0500
Subject: BusLogic build error in 2.5.3
From: Tim Sullivan <tsullivan@datawest.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 31 Jan 2002 11:27:42 -0700
Message-Id: <1012501663.1349.20.camel@prostock.ecom-tech.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/scsi/scsidrv.o: In function `BusLogic_InterruptHandler':
drivers/scsi/scsidrv.o(.text+0x80f7): undefined reference to
`scsi_mark_host_reset'
make: *** [vmlinux] Error 1

According to a note in the scsi_obsolete.c file, "Once the last
driver uses the new code this *ENTIRE* file will be nuked."

It seems that scsi_obsolete.c has been "nuked" prematurely :)

Regards,

tim


