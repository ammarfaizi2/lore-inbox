Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWCTGbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWCTGbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWCTGbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:31:36 -0500
Received: from mo00.po.2iij.net ([210.130.202.204]:40167 "EHLO
	mo00.po.2iij.net") by vger.kernel.org with ESMTP id S932091AbWCTGbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:31:35 -0500
Date: Mon, 20 Mar 2006 15:31:27 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] [MIPS] Cosmetic updates to sync with linux-mips
Message-Id: <20060320153127.520a6a50.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320043915.GB20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043915.GB20416@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 04:39:15 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> Make some cosmetic changes in order to bring mainline in sync
> with the linux-mips tree.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> 
> --- linux-2.6/arch/mips/Makefile	2006-03-13 18:45:54.000000000 +0000
> +++ mips.git/arch/mips/Makefile	2006-03-13 18:43:52.000000000 +0000
> @@ -498,6 +499,7 @@
>  cflags-$(CONFIG_PMC_YOSEMITE)	+= -Iinclude/asm-mips/mach-yosemite
>  load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
>  
> +#
>  # Qemu simulating MIPS32 4Kc
>  #
>  core-$(CONFIG_QEMU)		+= arch/mips/qemu/
> @@ -584,7 +586,7 @@
>  load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
>  
>  #
> -# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
> +# TANBAC TB0225 VR4131 Multi-chip module/TB0229 VR4131DIMM (VR4131)

The linux-mips tree is older than kernel.org about this line.

Yoichi
