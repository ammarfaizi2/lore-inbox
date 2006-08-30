Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWH3WmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWH3WmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWH3WmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:42:11 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:36004 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S932222AbWH3WmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:42:09 -0400
Date: Wed, 30 Aug 2006 18:40:54 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 7/9] parisc generic PAGE_SIZE
Message-ID: <20060830224054.GG3926@athena.road.mcmartin.ca>
References: <20060830221604.E7320C0F@localhost.localdomain> <20060830221609.DA8E9016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830221609.DA8E9016@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 03:16:09PM -0700, Dave Hansen wrote:
> This is the parisc portion to convert it over to the generic PAGE_SIZE
> framework.
> 
<snip>
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

This looks pretty ok by me. I'll give it a test-build tonight.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

> +config PARISC_LARGER_PAGE_SIZES
> +	def_bool y
>  	depends on PA8X00 && EXPERIMENTAL
>  

This should default to 'n' as I do not believe we yet have working >4K
pages yet.

Cheers! (Nice to see diffs with more '-' than '+' :)
	Kyle M.
