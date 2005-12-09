Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVLIDMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVLIDMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 22:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVLIDMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 22:12:33 -0500
Received: from ozlabs.org ([203.10.76.45]:25728 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751250AbVLIDMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 22:12:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17304.62700.697323.531625@cargo.ozlabs.ibm.com>
Date: Fri, 9 Dec 2005 14:07:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: janak@us.ibm.com
Cc: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 3/5] New system call, unshare (powerpc)
In-Reply-To: <1134079969.5476.14.camel@hobbs.atlanta.ibm.com>
References: <1134079969.5476.14.camel@hobbs.atlanta.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI writes:

> --- 2.6.15-rc5-mm1/include/asm-powerpc/unistd.h	2005-12-06
> 21:06:19.000000000 +0000
> +++
> 2.6.15-rc5-mm1+unshare-powerpc/include/asm-powerpc/unistd.h	2005-12-08
> 19:11:21.000000000 +0000
> @@ -296,8 +296,9 @@
>  #define __NR_inotify_init	275
>  #define __NR_inotify_add_watch	276
>  #define __NR_inotify_rm_watch	277
> +#define __NR_unshare		278

How does this apply against 2.6.15-rc5-mm1, which adds spu_run and
spu_create as syscalls 278 and 279?

Paul.
