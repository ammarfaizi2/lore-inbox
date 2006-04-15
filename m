Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWDOWbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWDOWbT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWDOWbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:31:19 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:50437 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932509AbWDOWbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:31:19 -0400
Date: Sun, 16 Apr 2006 00:31:17 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cleanup default value of MTD_PCMCIA_ANONYMOUS
Message-ID: <20060415223117.GE47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060415221644.GC47644@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060415221644.GC47644@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops got an additional tab in this one.
here is the corrected patch.

On Sun, Apr 16, 2006 at 12:16:44AM +0200, Jean-Luc Léger wrote:
> Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
> This patch removes wrong default for MTD_PCMCIA_ANONYMOUS.
> 
Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>
 
Index: linux-2.6.17-rc1/drivers/mtd/maps/Kconfig
===================================================================
--- linux-2.6.17-rc1/drivers/mtd/maps/Kconfig.old       2006-04-15 22:17:22.000000000 +0200
+++ linux-2.6.17-rc1/drivers/mtd/maps/Kconfig   2006-04-15 22:18:04.000000000 +0200
@@ -561,7 +561,6 @@
 config MTD_PCMCIA_ANONYMOUS
 	bool "Use PCMCIA MTD drivers for anonymous PCMCIA cards"
 	depends on MTD_PCMCIA
-	default N
 	help
 	  If this option is enabled, PCMCIA cards which do not report
 	  anything about themselves are assumed to be MTD cards.

