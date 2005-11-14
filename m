Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVKNXJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVKNXJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVKNXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:09:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751284AbVKNXJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:09:29 -0500
Date: Mon, 14 Nov 2005 15:09:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] atomic: atomic_inc_not_zero
Message-Id: <20051114150945.7078e51a.akpm@osdl.org>
In-Reply-To: <20051114140216.3481799a.pj@sgi.com>
References: <436416AD.3050709@yahoo.com.au>
	<4364171C.7020103@yahoo.com.au>
	<43641755.5010004@yahoo.com.au>
	<4364178E.8040502@yahoo.com.au>
	<20051114082956.609ff5cd.pj@sgi.com>
	<20051114134841.083ea51c.akpm@osdl.org>
	<20051114140216.3481799a.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > Please send patch.
> 
> I can't.  I don't understand what Nick intends here.
> If it's obvious to you, hit me with a clue stick,
> and I'd be glad to patch it.
> 

This, I assume?

--- 25/arch/sparc/lib/atomic32.c~sparc32-atomic32-build-fix	Mon Nov 14 15:08:44 2005
+++ 25-akpm/arch/sparc/lib/atomic32.c	Mon Nov 14 15:08:48 2005
@@ -66,7 +66,6 @@ int atomic_add_unless(atomic_t *v, int a
 	return ret != u;
 }
 
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 /* Atomic operations are already serializing */
 void atomic_set(atomic_t *v, int i)
 {
_

