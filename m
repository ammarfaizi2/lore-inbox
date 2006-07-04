Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWGDPYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGDPYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGDPYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:24:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:64685 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751191AbWGDPYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:24:37 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Date: Tue, 4 Jul 2006 17:23:46 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <20060704120242.GA3386@infradead.org> <Pine.LNX.4.64.0607040806580.13456@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607040806580.13456@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041723.46604.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I guess then we should drop ZONE_DMA (its a misnoner anyways since it 
> seems to indicate that DMA is only possible in this zone). Instead use
> 
> ZONE_ISA_DMA		-> ISA DMA Area (16 MB boundary)
> ZONE_32BIT_DMA		-> 32bit DMA area (well 900 MB on x86_64 but somewhere in that area)

It's 4GB on x86-64.

The 900MB refered to the boundary between NORMAL and HIGHMEM on i386.

-Andi
