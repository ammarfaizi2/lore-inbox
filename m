Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUJFC2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUJFC2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUJFC2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:28:10 -0400
Received: from mail.renesas.com ([202.234.163.13]:64463 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266474AbUJFC2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:28:05 -0400
Date: Wed, 06 Oct 2004 11:27:43 +0900 (JST)
Message-Id: <20041006.112743.635726864.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc3-mm2 0/5] [m32r] Remove arch/m32r/drivers
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please remove obsolete m32r-specific driver files
located at arch/m32r/drivers/ and the directory.

	* arch/m32r/Kconfig: Don't include arch/m32r/drivers/Kconfig.

	* arch/m32r/Makefile: Remove arch/m32r/drivers/.

	* arch/m32r/drivers/*: Removed.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.9-rc3-mm2 1/5] [m32r] Remove arch/m32r/drivers
[PATCH 2.6.9-rc3-mm2 2/5] [m32r] Remove arch/m32r/drivers/ds1302.c
[PATCH 2.6.9-rc3-mm2 3/5] [m32r] Remove arch/m32r/drivers/m32r_cfc.[ch]
[PATCH 2.6.9-rc3-mm2 4/5] [m32r] Remove arch/m32r/drivers/m32r_pcc.[ch]
[PATCH 2.6.9-rc3-mm2 5/5] [m32r] Remove arch/m32r/drivers/m5drv.c

 arch/m32r/Kconfig            |    2 
 arch/m32r/Makefile           |    1 
 arch/m32r/drivers/Kconfig    |   34 -
 arch/m32r/drivers/Makefile   |    7 

 arch/m32r/drivers/ds1302.c   |  432 --------------------
 arch/m32r/drivers/m32r_cfc.c |  910 -------------------------------------------
 arch/m32r/drivers/m32r_cfc.h |   85 ----
 arch/m32r/drivers/m32r_pcc.c |  821 --------------------------------------
 arch/m32r/drivers/m32r_pcc.h |   70 ---
 arch/m32r/drivers/m5drv.c    |  664 -------------------------------
 10 files changed, 3026 deletions(-)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
