Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUBRRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUBRRGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:06:16 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:18443 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266817AbUBRRGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:06:13 -0500
Date: Wed, 18 Feb 2004 17:06:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix update
Message-ID: <20040218170601.A10490@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Feb 18, 2004 at 08:41:18AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 08:41:18AM -0600, Pat Gefre wrote:
> Andrew,
> 
> Here's a small mod for Altix. It breaks up our 'pci fixup' function and
> has some other smallish clean ups.
> 
> For the ia64 crowd I've added 'platform_data' back into
> include/asm-ia64/pci.h
> 
> Can you take this ?

The patch looks okay, but this whole fixup-based pci initialization is
just plain wrong to start with.  I still wonder how this crap managed
to enter the tree..

