Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWBHKZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWBHKZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWBHKZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:25:06 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:16609 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932116AbWBHKZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:25:04 -0500
Date: Wed, 8 Feb 2006 10:23:42 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 4/9] ppc64 - Specify amount of kernel memory
 at boot time
In-Reply-To: <43E90BC1.7010907@austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0602081022090.20544@skynet>
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
 <20060126184425.8550.64598.sendpatchset@skynet.csn.ul.ie>
 <43E90BC1.7010907@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Joel Schopp wrote:

> > This patch adds the kernelcore= parameter for ppc64
>
> ...
>
> > diff -rup -X /usr/src/patchset-0.6/bin//dontdiff
> > linux-2.6.16-rc1-mm3-103_x86coremem/mm/page_alloc.c
> > linux-2.6.16-rc1-mm3-104_ppc64coremem/mm/page_alloc.c
> > --- linux-2.6.16-rc1-mm3-103_x86coremem/mm/page_alloc.c      2006-01-26
> > 18:09:04.000000000 +0000
> > +++ linux-2.6.16-rc1-mm3-104_ppc64coremem/mm/page_alloc.c    2006-01-26
> > 18:10:29.000000000 +0000
>
> Not to nitpick, but this chunk should go in a different patch, it's not ppc64
> specific.
>

You're right. It was put in here because it was testing this patch on
ppc64 that the bug was revealed. It should be moved to the patch that adds
the actual zone.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
