Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQKPLaW>; Thu, 16 Nov 2000 06:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbQKPLaN>; Thu, 16 Nov 2000 06:30:13 -0500
Received: from [209.249.10.20] ([209.249.10.20]:50642 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129848AbQKPLaG>; Thu, 16 Nov 2000 06:30:06 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Nov 2000 02:30:53 -0800
Message-Id: <200011161030.CAA01601@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: announce: isapnpmodules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I have written an isapnpmodules program that reads
/lib/modules/<version>/modules.isapnpmap and lists any kernel
modules corresponding to any ISA Plug'n'Play devices you have in
your system.  You must have the isa-pnp module itself either loaded
or compiled in when you run this program, because it uses
/proc/isapnp.

	isapnpmodules is FTPable from

ftp://ftp.yggdrasil.com/pub/dist/device_control/isapnpmodules/isapnpmodules-0.1.tar.gz.

	Note that, no modules in the stock 2.4.0-test11-pre5 tree
use the isapnp version of MODULE_DEVICE_TABLE yet, so isapnpmodules
is not yet of practical use.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
