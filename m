Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUEKHuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUEKHuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 03:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEKHuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 03:50:52 -0400
Received: from smtp08.web.de ([217.72.192.226]:46537 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262190AbUEKHur convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 03:50:47 -0400
From: Thomas Maguin <T.Maguin@web.de>
Reply-To: T.Maguin@web.de
To: linux-kernel@vger.kernel.org
Subject: Re: sata_sil bug
Date: Tue, 11 May 2004 09:53:23 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405110953.36293.T.Maguin@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Justin Cormack wrote:

> ata1: DMA timeout, stat 0x0
> ATA: abnormal status 0xD8 on port 0xF8807087
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 17 9b d9 80 00 00
> 20 00
> Current sda: sense = 70  3
> ASC= c ASCQ= 2
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x0c
> end_request: I/O error, dev sda, sector 396089728
> ATA: abnormal status 0xD8 on port 0xF8807087
> ATA: abnormal status 0xD8 on port 0xF8807087
> ATA: abnormal status 0xD8 on port 0xF8807087
> 

I was able to produce this error on my system too. It occured for me, when I 
compiled the ide interface of sil_3112 as a modul in to my kernel, although I 
was using the libata driver for my harddisks. I lost more then five times my 
sdb drive. After removing the ide modul, the system was rock stable again.

Tom
- -- 

- -------------------------------------------
protect your privacy - encrypt your mails
my key is: 0x2AA933B6
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoIZ+yat6ziqpM7YRAolbAJkBKrk8TYGzBUU2zemTuoFqWvdwOgCgyuQk
kSy0Sgn7TPGWQ1XLn00rut0=
=VWPw
-----END PGP SIGNATURE-----
