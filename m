Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVGaWys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVGaWys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGaWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:53:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35572 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262032AbVGaWvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:51:23 -0400
Subject: Re: realtime-preempt-2.6.13-rc4-RT-V0.7.52-07
From: Daniel Walker <dwalker@mvista.com>
To: "Shayne O'Connor" <forums@machinehasnoagenda.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42ED4E53.2010508@machinehasnoagenda.com>
References: <42ED4E53.2010508@machinehasnoagenda.com>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 15:51:14 -0700
Message-Id: <1122850274.29050.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can resolve it if you enable SMP .

Daniel

On Mon, 2005-08-01 at 08:18 +1000, Shayne O'Connor wrote:
> trying to compile 2.6.13.rc4 with ingo's RT patch 
> (realtime-preempt-2.6.13-rc4-RT-V0.7.52-07) but keep getting this error 
> near the end of compilation:
> 
>    GEN     .version
>    CHK     include/linux/compile.h
>    UPD     include/linux/compile.h
>    CC      init/version.o
>    LD      init/built-in.o
>    LD      .tmp_vmlinux1
> net/built-in.o(.text+0x2220c): In function `rt_check_expire':
> : undefined reference to `__bad_spinlock_type'
> net/built-in.o(.text+0x2222e): In function `rt_check_expire':
> : undefined reference to `__bad_spinlock_type'
> net/built-in.o(.text+0x22321): In function `rt_run_flush':
> : undefined reference to `__bad_spinlock_type'
> net/built-in.o(.text+0x22339): In function `rt_run_flush':
> : undefined reference to `__bad_spinlock_type'
> net/built-in.o(.text+0x22593): In function `rt_garbage_collect':
> : undefined reference to `__bad_spinlock_type'
> net/built-in.o(.text+0x225c1): more undefined references to 
> `__bad_spinlock_type' follow
> make: *** [.tmp_vmlinux1] Error 1
> [mrmachine@localhost linux-2.6.12]$
> 
> 
> i am trying to compile it with PREEMPT_DESKTOP ....
> 
> 
> (please CC me on any replies!)
> 
> 
> shayne
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

