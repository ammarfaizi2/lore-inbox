Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVDAAJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVDAAJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCaXuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:50:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:45024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262543AbVCaXYO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:14 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] i2c: add adt7461 chip support to lm90 driver's Kconfig entry
In-Reply-To: <11123113952683@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:15 -0800
Message-Id: <11123113951873@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2347, 2005/03/31 14:31:59-08:00, khali@linux-fr.org

[PATCH] i2c: add adt7461 chip support to lm90 driver's Kconfig entry

Hi Greg, James, all,

> > > Attached is another version of my adt7461 patch, for inclusion in
> > > the 2.6 tree. Reviewed by Jean.
>
> May we have an additional patch to Kconfig for this one?

Here it finally comes.

This simple patch adds a mention to the ADT7461 chip in Kconfig, now
that the lm90 driver supports it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/Kconfig |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-03-31 15:16:17 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-03-31 15:16:17 -08:00
@@ -233,6 +233,9 @@
 	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
 	  MAX6658 sensor chips.
 
+	  The Analog Devices ADT7461 sensor chip is also supported, but only
+	  if found in ADM1032 compatibility mode.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
 

