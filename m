Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUCVONs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUCVONs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:13:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51379
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261472AbUCVONr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:13:47 -0500
Date: Mon, 22 Mar 2004 15:14:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa1
Message-ID: <20040322141439.GY3649@dualathlon.random>
References: <20040322041629.GK3649@dualathlon.random> <Pine.LNX.4.44.0403220906280.20045-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403220906280.20045-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 09:07:54AM -0500, Rik van Riel wrote:
> On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> 
> > > > I renamed it primarly because rmap is the common name for the tecnique
> > > > of traking the pagetables with pte_chains
> > > 
> > > Funny, first thing I hear about that ;)
> > 
> > Not sure after all those discussions how you may not have ever noticed
> > that people uses objrmap to mean something different than rmap, it's
> > really hard to believe that you never noticed.
> 
> Most people seem to be talking about "pte based rmap" vs
> "object based rmap".  So far you're the only one who I've
> seen using "rmap" to mean just "pte based rmap" and not
> also "object based rmap".

then I'm the only one and I could have been biased because rmap.c is
including 99% of code for the pte based rmap, and my objrmap.c is including
99% of code for the objrect based _reverse_mappings_, still objrmap.c is
a more appropriate name for that stuff IMO (especially if somebody else
is mistaken as I am using the word rmap to mean the current 2.6 code in
mm/rmap.c).
