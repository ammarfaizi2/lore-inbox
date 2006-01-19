Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161471AbWASXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbWASXYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWASXYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:24:12 -0500
Received: from xenotime.net ([66.160.160.81]:58245 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161468AbWASXYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:24:10 -0500
Date: Thu, 19 Jan 2006 15:24:08 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] halt_on_oops command line option
In-Reply-To: <20060119151805.1c4dc2af.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601191520480.11660@shark.he.net>
References: <20060118232255.3814001b.akpm@osdl.org> <20060119073951.GC21663@redhat.com>
 <20060118235958.6b466a86.akpm@osdl.org> <20060119192654.GL21663@redhat.com>
 <20060119151805.1c4dc2af.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Andrew Morton wrote:

> diff -puN Documentation/kernel-parameters.txt~pause_on_oops-command-line-option Documentation/kernel-parameters.txt
> --- 25/Documentation/kernel-parameters.txt~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
> +++ 25-akpm/Documentation/kernel-parameters.txt	Thu Jan 19 14:51:35 2006
> @@ -544,6 +544,11 @@ running once the system is up.
>
>  	gvp11=		[HW,SCSI]
>
> +	pause_on_oops=
> +			Halt all CPUs after the first oops has been printed for
> +			the specified number of seconds.  This is to be used if
> +			your oopses keep scrolling off the screen.
> +
>  	hashdist=	[KNL,NUMA] Large hashes allocated during boot
>  			are distributed across NUMA nodes.  Defaults on
>  			for IA-64, off otherwise.

Why there?  Options are normally kept in alphabetical order,
like around line 1111 in 2.6.16-rc1/Documentation/kernel-parameters.txt.

-- 
~Randy
