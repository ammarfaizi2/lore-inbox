Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVAFRVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVAFRVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVAFRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:21:05 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:35217 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262924AbVAFRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:20:47 -0500
Date: Thu, 6 Jan 2005 12:20:48 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Jake Moilanen <moilanen@austin.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 1/4][RFC] Genetic Algorithm Library
In-Reply-To: <20050106101447.5ca4ca56@localhost>
Message-ID: <Pine.LNX.4.61.0501061216110.15896@lancer.cnet.absolutedigital.net>
References: <20050106100844.53a762a0@localhost> <20050106101447.5ca4ca56@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Jake Moilanen wrote:

Hi Jake,

> diff -puN fs/proc/proc_misc.c~genetic-lib fs/proc/proc_misc.c
> --- linux-2.6.9/fs/proc/proc_misc.c~genetic-lib	Wed Jan  5 15:45:54 2005
> +++ linux-2.6.9-moilanen/fs/proc/proc_misc.c	Wed Jan  5 15:45:54 2005
> @@ -45,6 +45,7 @@
>  #include <linux/sysrq.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched_cpustats.h>
> +#include <linux/genetic.h>
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
>  #include <asm/io.h>

This hunk fails, the line above the addition isn't in vanilla 2.6.9 - nor 
is the included file anywhere to be found either.

-- Cal

