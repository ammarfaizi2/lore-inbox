Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316879AbSEVHX7>; Wed, 22 May 2002 03:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSEVHX6>; Wed, 22 May 2002 03:23:58 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:60130 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316879AbSEVHX6>; Wed, 22 May 2002 03:23:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial 2.5.17: DMA-mapping.txt typo fix
Date: Wed, 22 May 2002 17:26:28 +1000
Message-Id: <E17AQVx-0007gt-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi <rl@hellgate.ch>: DMA-mapping.txt: sg_dma_length() -> sg_dma_len():

--- trivial-2.5.17/Documentation/DMA-mapping.txt.orig	Wed May 22 17:13:45 2002
+++ trivial-2.5.17/Documentation/DMA-mapping.txt	Wed May 22 17:13:45 2002
@@ -484,7 +484,7 @@
 of sg entries it mapped them to.
 
 Then you should loop count times (note: this can be less than nents times)
-and use sg_dma_address() and sg_dma_length() macros where you previously
+and use sg_dma_address() and sg_dma_len() macros where you previously
 accessed sg->address and sg->length as shown above.
 
 To unmap a scatterlist, just call:

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
