Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVCXBsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVCXBsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVCXBsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:48:54 -0500
Received: from mail.renesas.com ([202.234.163.13]:9371 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262385AbVCXBsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:48:50 -0500
Date: Thu, 24 Mar 2005 10:48:15 +0900 (JST)
Message-Id: <20050324.104815.304093279.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sugai@isl.melco.co.jp,
       ysato@users.sourceforge.jp, inaoka.kazuhiro@renesas.com,
       fujiwara@linux-m32r.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1] m32r: Update MMU-less support (0/3)
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patchset to update m32r's MMU-less support.
# Thanks to Naoto Sugai, Yoshinori Sato, Kazuhiro Inaoka, 
# and Hayato Fujiwara.

These patches can be applied to 2.6.11 or later.
Tested on an OAKS32R target.
Please apply.

Thanks,


[PATCH 2.6.12-rc1] m32r: Update MMU-less support (1/3)
- Fix syscall table for !CONFIG_MMU
- Fix EIT vector setup routine for !CONFIG_MMU

[PATCH 2.6.12-rc1] m32r: Update MMU-less support (2/3)
- Fix serial output routine
- Update mm_context_t definition

[PATCH 2.6.12-rc1] m32r: Update MMU-less support (3/3)
- Use m32r-elf-gcc for MMU-less targets
- Set up cache for M32102 chip
- Module support for !CONFIG_MMU

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
