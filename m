Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSCUXaZ>; Thu, 21 Mar 2002 18:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312567AbSCUXaR>; Thu, 21 Mar 2002 18:30:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8987 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312564AbSCUX35>; Thu, 21 Mar 2002 18:29:57 -0500
Date: Fri, 22 Mar 2002 00:29:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020322002924.X16801@dualathlon.random>
In-Reply-To: <127930000.1016651345@flay> <20020320212341.M4268@dualathlon.random> <20020320203520.A2003@infradead.org> <20020320223425.P4268@dualathlon.random> <20020320214607.A6363@infradead.org> <20020320230002.A16801@dualathlon.random> <20020321195451.GB4110@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 11:54:51AM -0800, Greg KH wrote:
> On Wed, Mar 20, 2002 at 11:00:02PM +0100, Andrea Arcangeli wrote:
> > But it is much faster to keep the kernel stack always in 4M global
> > tlbs, thus I don't think we need to change that in 2.5.  (also USB was
> > used to do dma in the kernel stack, not sure if they changed it
> > recently)
> 
> Hopefully all instances of the USB code doing that have now been fixed.
> If anyone sees any USB code that uses the kernel stack for USB
> transfers, please let me know so it can be fixed.
> 
> We (the USB group) have always known that this is a bug in our code, so
> don't feel you can't change things just because the USB code might be
> broken by it :)

Glad to hear, thanks!

Andrea
