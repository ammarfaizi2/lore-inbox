Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283510AbRLIPai>; Sun, 9 Dec 2001 10:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283527AbRLIPa1>; Sun, 9 Dec 2001 10:30:27 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:63944 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S283510AbRLIPaL>; Sun, 9 Dec 2001 10:30:11 -0500
Date: Sun, 9 Dec 2001 16:30:05 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: <linux-kernel@vger.kernel.org>
Subject: kmem_cache_alloc & kernel_lock
Message-ID: <Pine.LNX.4.33.0112091626110.27042-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can I use kmem_cache_alloc(mycache_cachep, SLAB_KERNEL) within
a kernel_lock/kernel_unlock block? Or should it be SLAB_ATOMIC?

Thanks in advance?

Frank.


