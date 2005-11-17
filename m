Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVKQNwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKQNwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKQNwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:52:42 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:2281 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750780AbVKQNwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:52:41 -0500
Date: Thu, 17 Nov 2005 22:52:36 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: YOSHIFUJI Hideaki / =?ISO-2022-JP?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: Compilation Error in arch/i386/apm.c
Message-Id: <20051117225236.21e13114.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20051117.115948.117652717.yoshfuji@linux-ipv6.org>
References: <20051117.115948.117652717.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005 11:59:48 +0900 (JST)
YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> wrote:

> Failed to compile current git tree.

Please check CONFIG_PM_LEGACY in your config.

Yoichi

> % make
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   CHK     usr/initramfs_list
>   CC [M]  arch/i386/kernel/apm.o
> arch/i386/kernel/apm.c: In function `apm_init':
> arch/i386/kernel/apm.c:2304: error: `pm_active' undeclared (first use in this function)
> arch/i386/kernel/apm.c:2304: error: (Each undeclared identifier is reported only once
> arch/i386/kernel/apm.c:2304: error: for each function it appears in.)
> arch/i386/kernel/apm.c: In function `apm_exit':
> arch/i386/kernel/apm.c:2410: error: `pm_active' undeclared (first use in this function)
> make[1]: *** [arch/i386/kernel/apm.o] Error 1
> make: *** [arch/i386/kernel] Error 2

