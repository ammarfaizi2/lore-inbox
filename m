Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUGMAum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUGMAum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUGMAum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:50:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48069 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264388AbUGMAuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:50:35 -0400
Date: Tue, 13 Jul 2004 02:50:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] remove outdated Stallion contact information
Message-ID: <20040713005031.GF4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error when trying to contact Stallion Technologies 
via the email address in MAINTAINERS:

<--  snip  -->

<support@stallion.oz.au>:
Sorry, I couldn't find a mail exchanger or IP address. (#5.4.4)

<--  snip  -->


I've checked their web page, and it only lists the cards in question as 
"discontinued products" and offers a Linux 2.0 and 2.2 driver version, 
which is hardly "Supported".

The patch below (applies against both 2.4 and 2.6) removes the bouncing 
email address from all files and removes the outdated MAINTAINERS entry.

diffstat output:
 MAINTAINERS               |    5 -----
 drivers/char/istallion.c  |    2 +-
 drivers/char/stallion.c   |    2 +-
 include/linux/cd1400.h    |    2 +-
 include/linux/cdk.h       |    2 +-
 include/linux/comstats.h  |    2 +-
 include/linux/istallion.h |    2 +-
 include/linux/sc26198.h   |    2 +-
 include/linux/stallion.h  |    2 +-
 9 files changed, 8 insertions(+), 13 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/MAINTAINERS.old	2004-07-13 02:33:51.000000000 +0200
+++ linux-2.6.7-mm7-full/MAINTAINERS	2004-07-13 02:39:38.000000000 +0200
@@ -1974,11 +1974,6 @@
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
-STALLION TECHNOLOGIES MULTIPORT SERIAL BOARDS
-M:	support@stallion.oz.au
-W:	http://www.stallion.com
-S:	Supported
-
 STARFIRE/DURALAN NETWORK DRIVER
 P:	Ion Badulescu
 M:	ionut@cs.columbia.edu
--- linux-2.6.7-mm7-full/drivers/char/istallion.c.old	2004-07-13 02:33:51.000000000 +0200
+++ linux-2.6.7-mm7-full/drivers/char/istallion.c	2004-07-13 02:39:43.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	istallion.c  -- stallion intelligent multiport serial driver.
  *
- *	Copyright (C) 1996-1999  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1999  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This code is loosely based on the Linux serial driver, written by
--- linux-2.6.7-mm7-full/drivers/char/stallion.c.old	2004-07-13 02:33:51.000000000 +0200
+++ linux-2.6.7-mm7-full/drivers/char/stallion.c	2004-07-13 02:39:49.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	stallion.c  -- stallion multiport serial driver.
  *
- *	Copyright (C) 1996-1999  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1999  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This code is loosely based on the Linux serial driver, written by
--- linux-2.6.7-mm7-full/include/linux/comstats.h.old	2004-07-13 02:33:51.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/comstats.h	2004-07-13 02:39:54.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	comstats.h  -- Serial Port Stats.
  *
- *	Copyright (C) 1996-1998  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1998  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This program is free software; you can redistribute it and/or modify
--- linux-2.6.7-mm7-full/include/linux/istallion.h.old	2004-07-13 02:33:52.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/istallion.h	2004-07-13 02:40:08.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	istallion.h  -- stallion intelligent multiport serial driver.
  *
- *	Copyright (C) 1996-1998  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1998  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This program is free software; you can redistribute it and/or modify
--- linux-2.6.7-mm7-full/include/linux/cd1400.h.old	2004-07-13 02:33:52.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/cd1400.h	2004-07-13 02:40:13.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	cd1400.h  -- cd1400 UART hardware info.
  *
- *	Copyright (C) 1996-1998  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1998  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This program is free software; you can redistribute it and/or modify
--- linux-2.6.7-mm7-full/include/linux/sc26198.h.old	2004-07-13 02:33:52.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/sc26198.h	2004-07-13 02:40:17.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	sc26198.h  -- SC26198 UART hardware info.
  *
- *	Copyright (C) 1995-1998  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1995-1998  Stallion Technologies
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
--- linux-2.6.7-mm7-full/include/linux/cdk.h.old	2004-07-13 02:33:52.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/cdk.h	2004-07-13 02:40:22.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	cdk.h  -- CDK interface definitions.
  *
- *	Copyright (C) 1996-1998  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1998  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This program is free software; you can redistribute it and/or modify
--- linux-2.6.7-mm7-full/include/linux/stallion.h.old	2004-07-13 02:33:52.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/stallion.h	2004-07-13 02:40:27.000000000 +0200
@@ -3,7 +3,7 @@
 /*
  *	stallion.h  -- stallion multiport serial driver.
  *
- *	Copyright (C) 1996-1998  Stallion Technologies (support@stallion.oz.au).
+ *	Copyright (C) 1996-1998  Stallion Technologies
  *	Copyright (C) 1994-1996  Greg Ungerer.
  *
  *	This program is free software; you can redistribute it and/or modify




