Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbTHUK7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbTHUK7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:59:16 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:18370 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262599AbTHUK7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:59:15 -0400
Date: Thu, 21 Aug 2003 12:59:12 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6][TRIVIAL] Update ide.txt documentation to current
 ide.c
In-Reply-To: <20030821124807.700db5d3.martin.zwickel@technotrend.de>
Message-ID: <Pine.LNX.4.51.0308211255040.24538@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0308211225120.23765@dns.toxicfilms.tv>
 <20030821124807.700db5d3.martin.zwickel@technotrend.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > + "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
> > + 			  allowwing ide-floppy, ide-tape, and ide-cdrom|writers

:) I kind of copy/pasted it from drivers/ide/ide.c so also apply to
drivers/ide/ide.c this:

diff -u linux-2.6.0-test2/drivers/ide/ide.c linux-2.6.0-test3/drivers/ide/ide.c
--- linux-2.6.0-test2/drivers/ide/ide.c	2003-08-19 17:30:07.000000000 +0200
+++ linux-2.6.0-test3/drivers/ide/ide.c	2003-08-21 12:56:40.000000000 +0200
@@ -1880,7 +1880,7 @@
  *				registered. In most cases, only one device
  *				will be present.
  * "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
- *				allowwing ide-floppy, ide-tape, and ide-cdrom|writers
+ *				allowing ide-floppy, ide-tape, and ide-cdrom|writers
  *				to use ide-scsi emulation on a device specific option.
  * "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
  *				where "xx" is between 20 and 66 inclusive,
