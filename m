Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWFRKXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWFRKXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWFRKXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:23:21 -0400
Received: from mx2.mail.ru ([194.67.23.122]:33334 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750988AbWFRKXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:23:21 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17: CONFIG_PARPORT_SERIAL should require CONFIG_SERIAL_8250_PCI?
Date: Sun, 18 Jun 2006 14:23:07 +0400
User-Agent: KMail/1.9.3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181423.17884.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just rebuilt 2.6.17 from older config and disabling 8250 PCI (I do not have 
any on notebook) and got:

WARNING: "pciserial_init_ports" [drivers/parport/parport_serial.ko] undefined!
WARNING: "pciserial_suspend_ports" [drivers/parport/parport_serial.ko] 
undefined!
WARNING: "pciserial_remove_ports" [drivers/parport/parport_serial.ko] 
undefined!
WARNING: "pciserial_resume_ports" [drivers/parport/parport_serial.ko] 
undefined!

# CONFIG_SERIAL_8250_PCI is not set
CONFIG_PARPORT_SERIAL=m

PARPORT_SERIAL is probably leftover that I overlooked, I do not actually need 
this either.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFElSmVR6LMutpd94wRAmDrAKCgKU5OIDhTqqPuyqNE8G1tHnzONACgq6+B
hvNakgfw8FQV4nUSfga8/DQ=
=oD/G
-----END PGP SIGNATURE-----
