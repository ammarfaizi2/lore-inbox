Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVG1BeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVG1BeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVG1Bcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:32:31 -0400
Received: from serv01.siteground.net ([70.85.91.68]:63396 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261479AbVG1BbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:31:11 -0400
Date: Wed, 27 Jul 2005 18:31:34 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shai@scalex86.org
Subject: Re: [patch] mm: Ensure proper alignment for node_remap_start_pfn
Message-ID: <20050728013134.GB23923@localhost.localdomain>
References: <20050728004241.GA16073@localhost.localdomain> <20050727181724.36bd28ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181724.36bd28ed.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 06:17:24PM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > While reserving KVA for lmem_maps of node, we have to make sure that
> > node_remap_start_pfn[] is aligned to a proper pmd boundary.
> > (node_remap_start_pfn[] gets its value from node_end_pfn[])
> > 
> 
> What are the effects of not having this patch applied?  Does someone's
> computer crash, or what?

Yes, it does cause a crash.

Thanks,
Kiran
