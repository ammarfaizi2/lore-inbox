Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUCCEwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUCCEbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:31:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:38018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262363AbUCCEWB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:01 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <10782873993927@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:39 -0800
Message-Id: <10782873992219@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1612.24.3, 2004/03/02 12:13:47-08:00, greg@kroah.com

Make IBMASM driver depend on X86 as that is the only valid platform for it.


 drivers/misc/Kconfig |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/misc/Kconfig b/drivers/misc/Kconfig
--- a/drivers/misc/Kconfig	Tue Mar  2 19:48:38 2004
+++ b/drivers/misc/Kconfig	Tue Mar  2 19:48:38 2004
@@ -6,6 +6,7 @@
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
+	depends on X86
 	default n
 	---help---
 	  This option enables device driver support for in-band access to the

