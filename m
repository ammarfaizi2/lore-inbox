Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUBZRbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUBZRbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:31:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:58296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261493AbUBZRbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:31:16 -0500
Date: Thu, 26 Feb 2004 09:35:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <linus@osdl.org>,
       anton@samba.org, paulus@samba.org, axboe@suse.de,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       hch@lst.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iSeries virtual disk
In-Reply-To: <20040226172325.3a139f73.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.58.0402260932580.7830@ppc970.osdl.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
 <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Stephen Rothwell wrote:
> 
> Unfortunately, things have moved on in the last couple of weeks and to
> fix everyone;s abjections, I need to include in this patch a ppc64 specific
> version of the dma_mapping routines.  They are pretty straight forward.

I'd _really_ like to see those as a separate patch and separately ack'ed 
as having been tested on the different DMA architectures.

		Linus
