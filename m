Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUJ2ORy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUJ2ORy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbUJ2ORx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:17:53 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:55556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263340AbUJ2OPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:15:32 -0400
Date: Fri, 29 Oct 2004 15:15:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop IRDA ISA dependency
Message-ID: <20041029141529.GA13092@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20041029130846.3D6639DF0EA9@verdi.suse.de> <20041029134549.GA12705@infradead.org> <20041029140357.GC15220@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029140357.GC15220@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 04:03:57PM +0200, Andi Kleen wrote:
> On Fri, Oct 29, 2004 at 02:45:49PM +0100, Christoph Hellwig wrote:
> > On Fri, Oct 29, 2004 at 03:08:46PM +0200, Andi Kleen wrote:
> > > 
> > > Make IRDA devices are not really ISA devices not depend on CONFIG_ISA.
> > > This allows to use them on x86-64
> > 
> > but this is bogus.  If it's using isa-style DMA it needs CONFIG_ISA.
> 
> No it doesn't. They work just fine with the patch applied on x86-64.

It doesn't on various other architectures.

