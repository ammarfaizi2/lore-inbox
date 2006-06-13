Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWFMWuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWFMWuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWFMWuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:50:32 -0400
Received: from deeprooted.net ([216.254.16.51]:35287 "EHLO paris.internal.net")
	by vger.kernel.org with ESMTP id S1751203AbWFMWub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:50:31 -0400
Subject: [PATCH-rt] ARM: add Kconfig support for HRT
From: Kevin Hilman <khilman@deeprooted.net>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Deep Root Systems
Date: Tue, 13 Jun 2006 15:50:31 -0700
Message-Id: <1150239031.21394.173.camel@vence.internal.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include kernel/time/Kconfig for ARM for HRT support

Signed-off-by: Kevin Hilman <khilman@deeprooted.net>

Index: ixp4xx/arch/arm/Kconfig
===================================================================
--- ixp4xx.orig/arch/arm/Kconfig
+++ ixp4xx/arch/arm/Kconfig
@@ -401,6 +401,8 @@ endmenu
 
 menu "Kernel Features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && REALVIEW_MPCORE


