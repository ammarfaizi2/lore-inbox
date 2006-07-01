Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWGADiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWGADiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWGADiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:38:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932409AbWGADiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:38:11 -0400
Date: Fri, 30 Jun 2006 20:34:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/bootmem.c: EXPORT_UNUSED_SYMBOL
Message-Id: <20060630203458.c8969d24.akpm@osdl.org>
In-Reply-To: <20060630113227.GO19712@stusta.de>
References: <20060630113227.GO19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:32:27 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> -EXPORT_SYMBOL(max_pfn);		/* This is exported so
> -				 * dma_get_required_mask(), which uses
> -				 * it, can be an inline function */
> +EXPORT_UNUSED_SYMBOL(max_pfn);  /*  June 2006  */

OK.
