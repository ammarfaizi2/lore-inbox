Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030737AbWJKAq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737AbWJKAq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030738AbWJKAq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:46:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48807 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030737AbWJKAqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:46:55 -0400
Date: Wed, 11 Oct 2006 02:46:54 +0200
From: Nick Piggin <npiggin@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SPAM: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault handlers
Message-ID: <20061011004654.GB25430@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010143342.GA5580@infradead.org> <20061010150142.GE2431@wotan.suse.de> <1160496546.3000.315.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160496546.3000.315.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 06:09:06PM +0200, Arjan van de Ven wrote:
> > \ What:	vm_ops.nopage
> > -When:	October 2008, provided in-kernel callers have been converted
> > +When:	October 2007, provided in-kernel callers have been converted
> >  Why:	This interface is replaced by vm_ops.fault, but it has been around
> >  	forever, is used by a lot of drivers, and doesn't cost much to
> >  	maintain.
> 
> but a year is a really long time; 6 months would be a lot more
> reasonable..
> (it's not as if most external modules will switch until it's really
> gone.. more notice isn't really going to help that at all; at least make
> the kernel printk once on the first use of this so that they notice!)

I agree with that. But the printk can't go in until all the in-tree
users are converted. I will  get around to doing that once the
interface is firmer.

As for timeframe, I don't have any strong feelings, but 6 months might
only be 1 kernel release, and we may not have got around to putting the
printk in yet ;)

