Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUHBLra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUHBLra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUHBLra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:47:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16543 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266477AbUHBLr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:47:27 -0400
Date: Mon, 2 Aug 2004 06:46:50 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
In-Reply-To: <20040731175518.407425bc.akpm@osdl.org>
Message-ID: <Pine.SGI.4.58.0408020645370.8791@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
 <20040728085737.26e0bfd2.akpm@osdl.org> <Pine.SGI.4.58.0407301640510.4902@gallifrey.americas.sgi.com>
 <20040731175518.407425bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Andrew Morton wrote:

> Breaks the build for all other architectures:
>
> Is this right?
>
> --- 25/drivers/char/Kconfig~snsc-build-fix	2004-07-31 17:53:52.818565424 -0700
> +++ 25-akpm/drivers/char/Kconfig	2004-07-31 17:54:39.658444680 -0700
> @@ -426,6 +426,7 @@ config A2232
>
>  config SGI_SNSC
>  	bool "SGI Altix system controller communication support"
> +	depends on CONFIG_IA64_SGI_SN2
>  	help
>  	  If you have an SGI Altix and you want to enable system
>  	  controller communication from user space (you want this!),
> _
>

No, it's not.  Christoph caught this and had a couple of other
suggestions too.  I'll fix and repost.  Sorry.

Thanks - Greg
