Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWGCXx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWGCXx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWGCXx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:53:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40616 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932300AbWGCXx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:53:58 -0400
Date: Mon, 3 Jul 2006 16:53:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
In-Reply-To: <200607040147.10995.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0607031653100.8657@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
 <20060703221712.GB14273@infradead.org> <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com>
 <200607040147.10995.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, Andi Kleen wrote:

> 
> > So we want to change the definition of ZONE_DMA to refer to the first 16MB 
> > only? ZONE_DMA32 is always a 4GB border? (Andy disagrees about DMA32 see 
> > his message!).
> 
> Hmm?  I didn't write anything about DMA32. Just noted a minor comment thinko about
> highmem.

The message was addressed to Christoph. You were only CCed. I fixed the 
issue you mentioined before. Thanks.

