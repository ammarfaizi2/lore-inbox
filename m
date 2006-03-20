Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWCTG04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWCTG04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWCTG04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:26:56 -0500
Received: from mo01.po.2iij.net ([210.130.202.205]:38869 "EHLO
	mo01.po.2iij.net") by vger.kernel.org with ESMTP id S1751655AbWCTG0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:26:55 -0500
Date: Mon, 20 Mar 2006 15:26:46 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] [MIPS] Improve description of VR41xx based
 machines
Message-Id: <20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320043902.GA20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043902.GA20416@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 04:39:02 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> MIPS supports various NEC VR41XX chips and not just the VR4100.
> Update Kconfig accordingly, thereby bringing the file in sync with
> the linux-mips tree.

The linux-mips tree is older than kernel.org about this part.

Yoichi

> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> 
> --- linux-2.6/arch/mips/Kconfig	2006-03-13 18:45:54.000000000 +0000
> +++ mips.git/arch/mips/Kconfig	2006-03-20 03:22:02.000000000 +0000
> @@ -503,7 +503,7 @@
>  	  ether port USB, AC97, PCI, etc.
>  
>  config MACH_VR41XX
> -	bool "Support for NEC VR4100 series based machines"
> +	bool "Support for NEC VR41XX-based machines"
>  	select SYS_HAS_CPU_VR41XX
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
> @@ -1134,7 +1134,7 @@
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select CPU_SUPPORTS_64BIT_KERNEL
>  	help
> -	  The options selects support for the NEC VR4100 series of processors.
> +	  The options selects support for the NEC VR41xx series of processors.
>  	  Only choose this option if you have one of these processors as a
>  	  kernel built with this option will not run on any other type of
>  	  processor or vice versa.
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
