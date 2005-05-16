Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVEPU7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVEPU7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEPU7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:59:46 -0400
Received: from dvhart.com ([64.146.134.43]:56737 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261878AbVEPU6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:58:01 -0400
Date: Mon, 16 May 2005 13:57:54 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc4-mm2 build failure in slab.c
Message-ID: <734040000.1116277074@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/slab.c:281: field `entry' has incomplete type
mm/slab.c: In function `cache_alloc_refill':
mm/slab.c:2497: warning: control reaches end of non-void function
mm/slab.c: In function `kmem_cache_alloc':
mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
mm/slab.c: In function `__kmalloc':
mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
make[1]: *** [mm/slab.o] Error 1
make[1]: *** Waiting for unfinished jobs....
