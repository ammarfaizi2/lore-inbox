Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263329AbUJ2OEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbUJ2OEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUJ2OEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:04:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:18378 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263329AbUJ2OEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:04:10 -0400
Date: Fri, 29 Oct 2004 16:03:57 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop IRDA ISA dependency
Message-ID: <20041029140357.GC15220@wotan.suse.de>
References: <20041029130846.3D6639DF0EA9@verdi.suse.de> <20041029134549.GA12705@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029134549.GA12705@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:45:49PM +0100, Christoph Hellwig wrote:
> On Fri, Oct 29, 2004 at 03:08:46PM +0200, Andi Kleen wrote:
> > 
> > Make IRDA devices are not really ISA devices not depend on CONFIG_ISA.
> > This allows to use them on x86-64
> 
> but this is bogus.  If it's using isa-style DMA it needs CONFIG_ISA.

No it doesn't. They work just fine with the patch applied on x86-64.

-Andi
> 
