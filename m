Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263651AbUJ3AII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbUJ3AII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbUJ3AG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:06:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:40065 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263708AbUJ3AEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:04:20 -0400
Date: Sat, 30 Oct 2004 02:04:12 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop IRDA ISA dependency
Message-ID: <20041030000412.GJ31914@wotan.suse.de>
References: <20041029130846.3D6639DF0EA9@verdi.suse.de> <20041029134549.GA12705@infradead.org> <20041029202214.GC18508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029202214.GC18508@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 09:22:14PM +0100, Dave Jones wrote:
> On Fri, Oct 29, 2004 at 02:45:49PM +0100, Christoph Hellwig wrote:
>  
>  > but this is bogus.  If it's using isa-style DMA it needs CONFIG_ISA.
> 
> Sounds like there is some confusion over what CONFIG_ISA means.
> I always understood it to mean 'We have ISA slots on this architecture'
> regardless of whether theres an ISA style LPC bus.
> Its a means of disabling a whole slew of drivers that have no
> meaning on a particular platform (in Andi's case, x86-64).

That's exactly my understanding too.

> Or did I get confused ?

I don't think so.

-Andi
