Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUDVDwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUDVDwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUDVDwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:52:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:37531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbUDVDwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:52:06 -0400
Date: Wed, 21 Apr 2004 20:51:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jgarzik@pobox.com, mpm@selenic.com,
       zwane@linuxpower.ca
Subject: [PATCH] Kconfig.debug family
Message-Id: <20040421205140.445ae864.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__21_Apr_2004_20_51_40_-0700_.tVDQC8WMSy_gmvm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__21_Apr_2004_20_51_40_-0700_.tVDQC8WMSy_gmvm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Localizes kernel debug options in lib/Kconfig.debug.
Puts arch-specific debug options in $ARCH/Kconfig.debug.

updated for 2.6.6-rc2

http://developer.osdl.org/rddunlap/patches/kconf_debug_1file_266rc2.patch

Also included here as a gzipped attachment.

 arch/alpha/Kconfig           |  104 ---------------------
 arch/alpha/Kconfig.debug     |   54 +++++++++++
 arch/arm/Kconfig             |  160 --------------------------------
 arch/arm/Kconfig.debug       |  113 +++++++++++++++++++++++
 arch/arm26/Kconfig           |  113 -----------------------
 arch/arm26/Kconfig.debug     |   58 +++++++++++
 arch/cris/Kconfig            |   14 --
 arch/cris/Kconfig.debug      |   14 ++
 arch/h8300/Kconfig           |   72 --------------
 arch/h8300/Kconfig.debug     |   66 +++++++++++++
 arch/i386/Kconfig            |  125 -------------------------
 arch/i386/Kconfig.debug      |   14 ++
 arch/ia64/Kconfig            |  114 -----------------------
 arch/ia64/Kconfig.debug      |   62 ++++++++++++
 arch/m68k/Kconfig            |   38 -------
 arch/m68k/Kconfig.debug      |    8 +
 arch/m68knommu/Kconfig       |   55 -----------
 arch/m68knommu/Kconfig.debug |   41 ++++++++
 arch/mips/Kconfig            |  119 ------------------------
 arch/mips/Kconfig.debug      |   66 +++++++++++++
 arch/parisc/Kconfig          |   49 ---------
 arch/parisc/Kconfig.debug    |    5 +
 arch/ppc/Kconfig             |  124 -------------------------
 arch/ppc/Kconfig.debug       |   71 ++++++++++++++
 arch/ppc64/Kconfig           |   80 ----------------
 arch/ppc64/Kconfig.debug     |   26 +++++
 arch/s390/Kconfig            |   56 -----------
 arch/s390/Kconfig.debug      |    6 +
 arch/sh/Kconfig              |  140 ----------------------------
 arch/sh/Kconfig.debug        |  110 ++++++++++++++++++++++
 arch/sparc/Kconfig           |   72 --------------
 arch/sparc/Kconfig.debug     |   13 ++
 arch/sparc64/Kconfig         |  104 ---------------------
 arch/sparc64/Kconfig.debug   |   37 +++++++
 arch/um/Kconfig              |   60 ------------
 arch/um/Kconfig.debug        |   34 ++++++
 arch/v850/Kconfig            |   29 -----
 arch/v850/Kconfig.debug      |    9 +
 arch/x86_64/Kconfig          |  101 --------------------
 arch/x86_64/Kconfig.debug    |   46 +++++++++
 init/Kconfig                 |    8 -
 lib/Kconfig.debug            |  211 +++++++++++++++++++++++++++++++++++++++++++
 42 files changed, 1084 insertions(+), 1717 deletions(-)


Like it, kill/drop it, fix (what?) problems, ... ?

--
~Randy

--Multipart=_Wed__21_Apr_2004_20_51_40_-0700_.tVDQC8WMSy_gmvm
Content-Type: application/octet-stream;
 name="kconf_debug_1file_266rc2.patch.gz"
Content-Disposition: attachment;
 filename="kconf_debug_1file_266rc2.patch.gz"
Content-Transfer-Encoding: base64

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

--Multipart=_Wed__21_Apr_2004_20_51_40_-0700_.tVDQC8WMSy_gmvm--
