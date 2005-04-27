Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVD0W06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVD0W06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVD0WZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:25:22 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:59531 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262057AbVD0WW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:22:29 -0400
Date: Thu, 28 Apr 2005 00:22:27 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] remove include/asm-mips/hp-lj/*
Message-ID: <20050427222227.GK3837@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused file 
include/asm-mips/hp-lj/asics.h (arch/mips/hp-lj was removed in 2.6.10
but it seems this file was forgotten).

include/asm-mips/hp-lj should be removed as it will be empty after that.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- ./include/asm-mips/hp-lj/asic.h	2005-03-02 08:38:26.000000000 +0100
+++ /dev/null	2005-04-21 09:16:22.079816680 +0200
@@ -1,7 +0,0 @@
-
-typedef enum { IllegalAsic, UnknownAsic, AndrosAsic, HarmonyAsic } AsicId;
-
-AsicId GetAsicId(void);
-
-const char* const GetAsicName(void);
-
