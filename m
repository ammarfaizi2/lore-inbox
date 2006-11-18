Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755986AbWKRFo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbWKRFo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKRFoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36843 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1753942AbWKRFoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:03 -0500
Date: Fri, 17 Nov 2006 21:43:52 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Manfred Spraul <manfred@colorfullife.com>,
       Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Message-Id: <20061118054352.8884.69397.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 2/7] Remove bio_cachep from slab.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bio_cachep from slab.h

bio_cachep is no longer used it seems.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:03:46.114062585 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:03:51.817677214 -0600
@@ -302,7 +302,6 @@ extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
 extern kmem_cache_t	*fs_cachep;
-extern kmem_cache_t	*bio_cachep;
 
 #endif	/* __KERNEL__ */
 
