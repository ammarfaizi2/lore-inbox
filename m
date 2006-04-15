Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWDOWja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWDOWja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWDOWja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:39:30 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:13320 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932140AbWDOWja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:39:30 -0400
Date: Sun, 16 Apr 2006 00:39:22 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup default value of IP_DCCP_ACKVEC
Message-ID: <20060415223921.GF47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch removes wrong default for IP_DCCP_ACKVEC.

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/net/dccp/Kconfig
===================================================================
--- linux-2.6.17-rc1/net/dccp/Kconfig.old       2006-04-15 22:48:36.000000000 +0200
+++ linux-2.6.17-rc1/net/dccp/Kconfig   2006-04-15 22:50:48.000000000 +0200
@@ -26,7 +26,7 @@
 
 config IP_DCCP_ACKVEC
 	depends on IP_DCCP
-	def_bool N
+	bool
 
 source "net/dccp/ccids/Kconfig"
 

