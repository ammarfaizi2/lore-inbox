Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWFQUwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWFQUwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 16:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWFQUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 16:52:08 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46802 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750889AbWFQUwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 16:52:08 -0400
Date: Sat, 17 Jun 2006 22:52:05 +0200 (MEST)
Message-Id: <200606172052.k5HKq5IX002958@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.4.33-rc1] updated patch kit for gcc-4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated patch kit allowing gcc-4.1.1 to compile the 2.4.33-rc1 kernel is now available:
<http://user.it.uu.se/~mikpe/linux/patches/2.4/patch-gcc4-fixes-v15-2.4.33-rc1>

Changes since the previously announced version of the patch kit
<http://marc.theaimsgroup.com/?l=linux-kernel&m=114149697417107&w=2>:

- Merged the fixes for gcc-4.1 into the baseline patch kit for gcc-4.0.
- I previously reported that gcc-4.1.0 built ppc32 kernels that oopsed
  in shrink_dcache_parent(). gcc-4.1.1 fixed this issue.
- The architectures known to work in kernel 2.4.33-rc1 + this patch kit
  with gcc-4.1.1 and gcc-4.0.3 are i386, x86-64, and ppc32.

/Mikael
