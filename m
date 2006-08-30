Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWH3WsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWH3WsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWH3WsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:48:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:17792 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750992AbWH3WsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:48:15 -0400
Subject: Re: [RFC][PATCH 7/9] parisc generic PAGE_SIZE
From: Dave Hansen <haveblue@us.ibm.com>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060830224054.GG3926@athena.road.mcmartin.ca>
References: <20060830221604.E7320C0F@localhost.localdomain>
	 <20060830221609.DA8E9016@localhost.localdomain>
	 <20060830224054.GG3926@athena.road.mcmartin.ca>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 15:48:05 -0700
Message-Id: <1156978085.31295.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 18:40 -0400, Kyle McMartin wrote:
> On Wed, Aug 30, 2006 at 03:16:09PM -0700, Dave Hansen wrote:
> > This is the parisc portion to convert it over to the generic PAGE_SIZE
> > framework.
> > 
> <snip>
> > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> 
> This looks pretty ok by me. I'll give it a test-build tonight.

That'd be great.  Thanks!

> > +config PARISC_LARGER_PAGE_SIZES
> > +	def_bool y
> >  	depends on PA8X00 && EXPERIMENTAL
> >  
> 
> This should default to 'n' as I do not believe we yet have working >4K
> pages yet.

This actually just defaults to enables the option to _appear_ in the
top-level Kconfig file.  The default from the top-level Kconfig file
should still be 4k for parisc.

-- Dave

