Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUA1WYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266230AbUA1WYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:24:08 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:29920 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S266222AbUA1WXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:23:43 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH] 2.4.25pre7 warning fix
References: <m3u12hcc9f.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58L.0401280939400.1311@logos.cnet>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 28 Jan 2004 23:17:12 +0100
In-Reply-To: <Pine.LNX.4.58L.0401280939400.1311@logos.cnet> (Marcelo
 Tosatti's message of "Wed, 28 Jan 2004 09:42:30 -0200 (BRST)")
Message-ID: <m34quf7m6v.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> Btw, why do we need cyclone_setup() for !CONFIG_X86_SUMMIT ?
>
> /* No-cyclone stubs */
> #ifndef CONFIG_X86_SUMMIT
> int __init cyclone_setup(char *str)
> {
>         printk(KERN_ERR "cyclone: Kernel not compiled with
> CONFIG_X86_SUMMIT, cannot use the cyclone-timer.\n");
>         return 1;
> }

No idea. All the stubs seem strange to me. I will make another patch
to address that.
-- 
Krzysztof Halasa, B*FH
