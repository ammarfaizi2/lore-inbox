Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbRFNNuh>; Thu, 14 Jun 2001 09:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbRFNNuS>; Thu, 14 Jun 2001 09:50:18 -0400
Received: from AMontpellier-201-1-1-185.abo.wanadoo.fr ([193.252.31.185]:13331
	"EHLO awak") by vger.kernel.org with ESMTP id <S262649AbRFNNuL>;
	Thu, 14 Jun 2001 09:50:11 -0400
Subject: IDE read error hangs kernel
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 14 Jun 2001 15:46:20 +0200
Message-Id: <992526381.5875.9.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a DVD (IDE, using ide-scsi) with read errors, and when reading it
(UDF-mounted or directly with xine) on the read error the drive clicks,
I have an error in the log and, after a while, the kernel hangs.


Here is the (hand-copied) log:

scsi0:  ERROR on channel 0, id 1, lun 0, CDB: Request Sense 00 00 00 40 00
Info fld=0x1f6fa0, Current sd0b:00: sense key Medium Error
Additional sense indicates Unrecovered read error
 I/O error: dev 0b:00, sector 8240768
scsi : aborting command due to timeout : pid 0, scsi 0, channel 0, id 1, lun 0 Read (10) 00 00 1f 6f a2 00 00 06 00


Any hint to make this non-fatal ?

Xav

