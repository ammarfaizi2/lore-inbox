Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUDHDmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 23:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUDHDmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 23:42:42 -0400
Received: from mail.renesas.com ([202.234.163.13]:44969 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261497AbUDHDmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 23:42:40 -0400
Date: Thu, 08 Apr 2004 12:42:26 +0900 (JST)
Message-Id: <20040408.124226.699107749.takata.hirokazu@renesas.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] m32r: 2.6.4 kernel with noMMU support
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to announce the latest 2.6.4 kernel release for 
the Renesas M32R processor.

In this release, MMU-less targets such as M32102 microcontrollers are
newly supported, and an OAKS32R, a tiny and inexpensive board, is newly
supported as a Linux/M32R embedded platform.

Patch information to the stock linux-2.6.4 kernel is placed as follows:
- m32r architecture dependent portions (arch/m32r, include/asm-m32r)
  http://www.linux-m32r.org/public/linux-2.6.4_m32r_20040406.arch-m32r.patch
- architecture independent portions for the m32r
  http://www.linux-m32r.org/public/linux-2.6.4_m32r_20040406.patch

We are now packaging other noMMU support stuffs for the M32R processor; 
library(uClibc) and cross tools (m32r-elf GNU tools and elf2flt
utility) and so on. 
I hope we can also release them via our homepage soon.

Regards,
---
Hirokazu Takata,  
Linux/M32R Project: http://www.linux-m32r.org/
