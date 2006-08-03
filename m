Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWHCHo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWHCHo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHCHo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:44:58 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:10182 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932325AbWHCHo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:44:57 -0400
Subject: [PATCH 4/4] Remove unused include from efi_stub.S
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
In-Reply-To: <1154591038.11423.56.camel@localhost.localdomain>
References: <1154590902.11423.52.camel@localhost.localdomain>
	 <1154590994.11423.54.camel@localhost.localdomain>
	 <1154591038.11423.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:44:55 +1000
Message-Id: <1154591096.11423.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary include from efi_stub.S

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.18-rc2-mm1-zach-3/arch/i386/kernel/efi_stub.S working-2.6.18-rc2-mm1-zach-4/arch/i386/kernel/efi_stub.S
--- working-2.6.18-rc2-mm1-zach-3/arch/i386/kernel/efi_stub.S	2006-07-21 20:27:02.000000000 +1000
+++ working-2.6.18-rc2-mm1-zach-4/arch/i386/kernel/efi_stub.S	2006-08-03 17:30:34.000000000 +1000
@@ -7,7 +7,6 @@
 
 #include <linux/linkage.h>
 #include <asm/page.h>
-#include <asm/pgtable.h>
 
 /*
  * efi_call_phys(void *, ...) is a function with variable parameters.

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

