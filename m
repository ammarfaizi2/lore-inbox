Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVGOWRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVGOWRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGOWPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:15:15 -0400
Received: from smtp06.auna.com ([62.81.186.16]:16092 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262078AbVGOWMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:12:33 -0400
Date: Fri, 15 Jul 2005 22:12:31 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] SCSI SATA is a tristate
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1121465068l.13352l.0l@werewolf.able.es> (from
	jamagallon@able.es on Sat Jul 16 00:04:28 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1121465551l.13352l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.11] Login:jamagallon@able.es Fecha:Sat, 16 Jul 2005 00:12:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, J.A. Magallon wrote:
> 
> On 07.15, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > 

--- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
@@ -447,7 +447,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	bool "Serial ATA (SATA) support"
+	tristate "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam9 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


