Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVAMTvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVAMTvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVAMTrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:47:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:60339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261473AbVAMTqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:46:36 -0500
Date: Thu, 13 Jan 2005 11:46:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <41E6C507.5050302@comcast.net>
Message-ID: <Pine.LNX.4.58.0501131142500.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> 
 <20050112185133.GA10687@kroah.com>  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
  <20050112161227.GF32024@logos.cnet>  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
  <20050112205350.GM24518@redhat.com>  <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
  <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
  <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>  <20050113082320.GB18685@infradead.org>
  <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
 <1105632757.4624.59.camel@localhost.localdomain> <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
 <41E6C507.5050302@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, John Richard Moser wrote:
> 
> > So all security issues are about balancing cost vs gain. I'm convinced
> > that the gain from openness is higher than the cost. Others will disagree.  
> 
> Yes.  Nobody code audits your binaries.  You need source code to do
> source code auditing.  :)

Oh, it's very clear that some exploits have definitely been written by
looking at the source code with automated tools or by instrumenting
things, and that the exploits would likely have never been found without
source code. That's fine. We just have higher requirements in the open
source community.

And I do think that the same is true for being open about security
advisories: I think that to offset an open security list, we'd have to
then have more "best practices" than a vendor-sec-type closed security
list might need. I think it would be worth it.

			Linus
