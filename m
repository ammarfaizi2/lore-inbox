Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWDMQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWDMQzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWDMQzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:55:20 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:49641 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751061AbWDMQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:55:18 -0400
Date: Thu, 13 Apr 2006 18:55:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 4/4] Remove unused types
Message-ID: <20060413165509.GH30574@wohnheim.fh-wedel.de>
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060413165153.GD30574@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three types are never set or checked for.  Remove.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 include/mtd/mtd-abi.h |    3 ---
 1 file changed, 3 deletions(-)


--- mtd_type/include/mtd/mtd-abi.h~unused_types	2006-04-13 18:32:42.000000000 +0200
+++ mtd_type/include/mtd/mtd-abi.h	2006-04-13 18:34:14.000000000 +0200
@@ -28,10 +28,7 @@ struct mtd_oob_buf {
 #define MTD_ROM			2
 #define MTD_NORFLASH		3
 #define MTD_NANDFLASH		4
-#define MTD_PEROM		5
 #define MTD_DATAFLASH		6
-#define MTD_OTHER		14
-#define MTD_UNKNOWN		15
 
 #define MTD_CLEAR_BITS		1       // Bits can be cleared (flash)
 #define MTD_SET_BITS		2       // Bits can be set
