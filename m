Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWGCW3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWGCW3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGCW3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:29:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:4489 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751129AbWGCW3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:29:00 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 1/8] Rework mmzone.h: Make DMA32 and HIGHMEM optional
Date: Tue, 4 Jul 2006 00:28:41 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <20060703215540.7566.36862.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060703215540.7566.36862.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607040028.41129.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 23:55, Christoph Lameter wrote:

> +#ifdef CONFIG_HIGHMEM
> +	/*
> +	 * A memory area that is only addressable by the kernel through
> +	 * mapping portions into its own address space. This is for example
> +	 * used by i386 to allow the kernel to address the memory beyond
> +	 * 4G. 

s/4G/900MB/

Rest of the patch looks fine.

-Andi
