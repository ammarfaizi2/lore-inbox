Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271683AbRHUOK4>; Tue, 21 Aug 2001 10:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271686AbRHUOKr>; Tue, 21 Aug 2001 10:10:47 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:26896 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S271681AbRHUOKi> convert rfc822-to-8bit; Tue, 21 Aug 2001 10:10:38 -0400
Date: Tue, 21 Aug 2001 16:08:09 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Linux <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: Pam Delaney <pam.delaney@lsil.com>
Subject: PATCH: SYM-2 driver for Linux-2.5 (proposal)
Message-ID: <20010821155640.D337-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

My proposal for inclusion of the SYM-2 driver in Linux 2.5 is available
from the following location (modulo mistakes :)):

ftp://ftp.tux.org/pub/roudier/drivers/linux/experimental/sym-2.1.11-linux-2.4.8-01.patch.gz

The patch is against kernel 2.4.8. It should also apply to 2.4.9 , but I
didn't give this latest kernel a try for the moment.

The proposal consists in the following:

- The current SYM53C8XX and NCR53C8XX drivers are left in place.
- The current SYM53C8XX driver name is now "SYM53C8XX Version 1".
- For historical reasons, the new driver name is "SYM53C8XX Version 2"
- The new driver files are added in linux/drivers/scsi/sym53c8xx_2/
- When linked statically, the 2 SYM53C8XX driver versions are mutually
  exclusives.

This proposal also applies to inclusion in either 2.4.X kernel or 2.2.X
kernel if this ever gets desirable.

Comments, reports and fixes are welcome.

Regards,
  Gérard.

