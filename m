Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbSLLAE7>; Wed, 11 Dec 2002 19:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbSLLAE7>; Wed, 11 Dec 2002 19:04:59 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:41738 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267366AbSLLAE6>; Wed, 11 Dec 2002 19:04:58 -0500
Date: Thu, 12 Dec 2002 00:12:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/2) i386 discontigmem support against 2.4.21pre1: paddr_to_pfn
Message-ID: <20021212001242.A10910@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <200212112335.gBBNZpu04590@w-gaughen.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212112335.gBBNZpu04590@w-gaughen.beaverton.ibm.com>; from gone@us.ibm.com on Wed, Dec 11, 2002 at 03:35:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 03:35:51PM -0800, Patricia Gaughen wrote:
> It changes all references of node_start_paddr and zone_start_paddr 
> to node_start_pfn and zone_start_pfn.  This change is required to 
> support PAE for i386 discontigmem.  It allows a starting address 
> for a node or zone to be greater than 4GB. A version of this patch 
> is in the 2.4 aa tree and has also been accepted into the v2.5 tree 
> starting with 2.5.34.
> 
> I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
> multiquad, multiquad PAE, multiquad DISCONTIGMEM, multiquad DISCONTIGMEM PAE.
> 
> Any and all feedback regarding this patch is greatly appreciated.

The patch looks cool.  If it was inline in the mail instead of beeing a
mime-attachment everyone could even see that easily 8)

