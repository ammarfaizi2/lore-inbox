Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVADTiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVADTiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVADTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:35:45 -0500
Received: from holomorphy.com ([207.189.100.168]:11402 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261534AbVADTLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:11:13 -0500
Date: Tue, 4 Jan 2005 11:11:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [5/7] LEON SPARC V8 processor support for linux-2.6.10
Message-ID: <20050104191105.GN2708@holomorphy.com>
References: <41DAE8BB.7050501@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DAE8BB.7050501@gaisler.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:04:27PM +0100, Jiri Gaisler wrote:
> Leon3 serial+ethermac driver:
> [5/7] diff2.6.10_arch_sparc_Kocnfig.diff  diff for arch/sparc/Kconfig
> --- ../linux-2.6.10-driver/arch/sparc/Kconfig	2005-01-03 18:03:49.000000000 +0100
> +++ linux-2.6.10/arch/sparc/Kconfig	2005-01-03 18:01:44.000000000 +0100
> @@ -239,12 +239,6 @@
>  	  Say Y here if you are running on a Leon3 from grlib
>  	  (download from www.gaisler.com). 
>  
> -if LEON_3
> -
> -source "drivers/amba/Kconfig"
> -
> -endif
> -
>  endif

This one is a bit unusual. It doesn't seem to have been added by a
previous patch. The intended effect may have been something else. Were
there supposed to be drivers in this patch?


-- wli
