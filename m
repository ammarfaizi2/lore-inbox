Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbUAFXvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbUAFXvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:51:47 -0500
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:41636 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id S265443AbUAFXvp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:51:45 -0500
From: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
To: linux-kernel@vger.kernel.org
Subject: Kconfig entryf or Pegasus USB Ethernet device
Date: Wed, 7 Jan 2004 00:51:33 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200401070051.40350.vergata@stud.fbi.fh-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

Just a small hint for USB Ethernet device.

I only have 1000Mbit card and for testing purpose an External USB 
Ethernetdongle, so why should I build Ethernet 10 /100 Mbit when i only need 
an USB Network adapter.

So if I'm right this should work too just like the other devices too.

CU Sergio

- --- Kconfig.old 2004-01-06 21:26:37.000000000 +0100
+++ Kconfig     2004-01-06 21:35:53.000000000 +0100
@@ -69,7 +69,7 @@

 config USB_PEGASUS
        tristate "USB Pegasus/Pegasus-II based ethernet device support"
- -       depends on USB && NET_ETHERNET
+       depends on USB && NET
        select MII
        ---help---
          Say Y here if you know you have Pegasus or Pegasus-II based adapter.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+0oKVP5w5vF/2y8RAoaaAKCauI7Atzrkc6HpxUXM77YZeE9UGwCg7JKF
VYTBCKqlhFPtDsOhflbh54s=
=M0Jf
-----END PGP SIGNATURE-----
