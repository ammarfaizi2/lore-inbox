Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbWKOPBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbWKOPBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWKOPBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:01:32 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37784
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030531AbWKOPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:01:31 -0500
Message-Id: <455B3A24.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 15 Nov 2006 15:02:44 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <patches@x86-64.org>
Subject: [PATCH] remove prototype of free_bootmem_generic()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function doesn't exist (anymore).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc5/include/asm-x86_64/proto.h	2006-11-08 09:25:39.000000000 +0100
+++ 2.6.19-rc5-x86_64-misc/include/asm-x86_64/proto.h	2006-11-06 09:10:17.000000000 +0100
@@ -61,7 +61,6 @@ extern void numa_initmem_init(unsigned l
 extern unsigned long numa_free_all_bootmem(void);
 
 extern void reserve_bootmem_generic(unsigned long phys, unsigned len);
-extern void free_bootmem_generic(unsigned long phys, unsigned len);
 
 extern void load_gs_index(unsigned gs);
 


