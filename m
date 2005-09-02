Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030677AbVIBEbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbVIBEbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbVIBEbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:31:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030677AbVIBEbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:31:11 -0400
Date: Thu, 1 Sep 2005 21:29:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Message-Id: <20050901212929.52e2d2d6.akpm@osdl.org>
In-Reply-To: <20050901.180723.982928921.hyoshiok@miraclelinux.com>
References: <20050824.231156.278740508.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<p73ll2rfgv7.fsf@verdi.suse.de>
	<20050825.135420.640917643.hyoshiok@miraclelinux.com>
	<20050901.180723.982928921.hyoshiok@miraclelinux.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiro Yoshioka <hyoshiok@miraclelinux.com> wrote:
>
> --- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05 16:04:37.000000000 +0900
>  +++ linux-2.6.12.4.nt/arch/i386/lib/usercopy.c	2005-09-01 17:09:41.000000000 +0900

Really.  Please redo and retest the patch against a current kernel.
