Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRK3SvV>; Fri, 30 Nov 2001 13:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280952AbRK3Su0>; Fri, 30 Nov 2001 13:50:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40090 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S280960AbRK3StS>;
	Fri, 30 Nov 2001 13:49:18 -0500
Date: Sat, 1 Dec 2001 00:24:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: SLAB_HWCACHE_ALIGN question
Message-ID: <20011201002411.A12832@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Why does SLAB_HWCACHE_ALIGN forces alignment on L1_CACHE_BYTES
and not SMP_CACHE_BYTES ? Does this have anything to do with
fitting cache objects in a single L1 cache line even when it
is uniprocessor and SMP_CACHE_BYTES is no equal to L1_CACHE_BYTES ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
