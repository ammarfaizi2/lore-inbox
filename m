Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVJERLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVJERLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVJERLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:11:10 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40088 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030263AbVJERLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:11:08 -0400
Date: Wed, 5 Oct 2005 18:11:06 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
In-Reply-To: <1128530989.26009.30.camel@localhost>
Message-ID: <Pine.LNX.4.58.0510051759240.16421@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie> 
 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
 <1128530989.26009.30.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Dave Hansen wrote:

> On Wed, 2005-10-05 at 15:46 +0100, Mel Gorman wrote:
> >
> > +#ifdef CONFIG_ALLOCSTATS
> > +       zone->reserve_count[type]++;
> > +#endif
>
> Did this sneak up from another patch?
>

Worse, it is not active until a later patch - 007_stats. Both patches
fixed now.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
