Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUIANYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUIANYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUIANYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:24:33 -0400
Received: from mail.renesas.com ([202.234.163.13]:48127 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266666AbUIANXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:23:48 -0400
Date: Wed, 01 Sep 2004 22:23:29 +0900 (JST)
Message-Id: <20040901.222329.719888990.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] [m32r] Upgrade to 2.6.7 kernel
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to send a 2.6.7 kernel patch for Renesas M32R processor.
Would you consider to include this patch to the Linux kernel tree?

Patch information to the stock 2.6.7 kernel is placed as follows:
- m32r architecture dependent portions (arch/m32r, include/asm-m32r)
  http://www.linux-m32r.org/public/linux-2.6.7_m32r_20040819.arch-m32r.patch


In this release,
* Clean up
  All workaround code for old m32r-linux-gcc are completely removed
  from the architecture-independent portions.

* Add new drivers
  - AR (artificial retina) camera is newly supported.
    AR camera module: Renesas M64278E-800, VGA(640x480 pixcels)
    http://www.renesas.com/avs/resource/japan/jpn/pdf/assp/rjj01f0005_psmobile.pdf
  - Frame buffer device driver for LCD panel/CRT display is supported.
    Display controller: EPSON S1D13806

  These drivers are put into architecture-independent portions, 
  so they are not included in the above patch.
  (see also http://www.linux-m32r.org/eng/download.html)
  

Best Regards,
--
Hirokazu Takata
Linux/M32R Project: http://www.linux-m32r.org/
