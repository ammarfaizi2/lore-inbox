Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSFOSXB>; Sat, 15 Jun 2002 14:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSFOSXA>; Sat, 15 Jun 2002 14:23:00 -0400
Received: from holomorphy.com ([66.224.33.161]:1195 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315456AbSFOSW7>;
	Sat, 15 Jun 2002 14:22:59 -0400
Date: Sat, 15 Jun 2002 11:22:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: remove unnecessary headers from mm/page_alloc.c
Message-ID: <20020615182241.GQ25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

page_alloc.c does not use either slab.h or swapctl.h. This removes the
inclusion of those headers from page_alloc.c

Cheers,
Bill


===== mm/page_alloc.c 1.67 vs edited =====
--- 1.67/mm/page_alloc.c	Mon Jun  3 08:25:10 2002
+++ edited/mm/page_alloc.c	Sat Jun 15 11:21:33 2002
@@ -15,11 +15,9 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
-#include <linux/slab.h>
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
