Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbTCQPJa>; Mon, 17 Mar 2003 10:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCQPJa>; Mon, 17 Mar 2003 10:09:30 -0500
Received: from 237.oncolt.com ([213.86.99.237]:46557 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261720AbTCQPJ3>; Mon, 17 Mar 2003 10:09:29 -0500
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <26040.1047888163@kao2.melbourne.sgi.com>
References: <26040.1047888163@kao2.melbourne.sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047914414.28282.91.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 17 Mar 2003 15:20:15 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 08:02, Keith Owens wrote:
> Automatic decoding of oops on 2.5 has been very useful, so this patch
> adds kksymoops support to 2.4.21-pre5.  Currently only for i386 and
> ia64, other architectures are easy to add.

> +KALLSYMS	= /sbin/kallsyms

Kallsyms is arch-specific, isn't it? So shouldn't that be
$(CROSS_COMPILE)kallsyms?

How does one go about making non-native kallsyms? 

The 2.5 kallsyms doesn't break cross-compilation, does it?

-- 
dwmw2

