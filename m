Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbULPFDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbULPFDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 00:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbULPFDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 00:03:13 -0500
Received: from mail.suse.de ([195.135.220.2]:23233 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262588AbULPFCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 00:02:52 -0500
Date: Thu, 16 Dec 2004 06:02:48 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@suse.de>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org, jrsantos@austin.ibm.com
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041216050248.GG32718@wotan.suse.de>
References: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <50260000.1103061628@flay> <20041215045855.GH27225@wotan.suse.de> <20041215144730.GC24000@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215144730.GC24000@krispykreme.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> specSFS (an NFS server benchmarmk) has been very sensitive to TLB issues
> for us, it uses all the memory as pagecache and you end up with 10
> million+ dentries. Something similar that pounds on the dcache would be
> interesting.

I asked Brent to run some benchmarks originally and I believe he has 
already run all that he could easily set up. If you want more testing
you'll need to test yourself I think. 

At least I don't think this patch should be further stalled unless
someone actually comes up with a proof that it actually affects
performance.

-Andi
