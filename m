Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbULOJOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbULOJOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbULOJOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:14:14 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:44240 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262239AbULOJOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:14:10 -0500
Date: Wed, 15 Dec 2004 10:14:09 +0100
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041215091409.GA20090@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com> <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de> <19030000.1103054924@flay> <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <20041215040854.GC27225@wotan.suse.de> <41BFEAA5.1090109@cosmosbay.com> <20041215074636.GR27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215074636.GR27225@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2) What are the exact number of data TLB entries (for small pages and 
> > huge ones) for opterons ?
> 
> check the data sheets, but iirc 64 large DTLBs and 1024+ 4K DTLBS.
> That is the L2 TLB, there is also a L1 but it is likely inclusive (?)

After checking the data sheets it is actually 32 2MB DLTBs and 512 4K DTLBs
(L2). And the same for the ITLB. 

-Andi
