Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVACP7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVACP7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVACP7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:59:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:45324 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261363AbVACP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:59:33 -0500
Subject: Re: starting with 2.7
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Rik van Riel <riel@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050103153438.GF2980@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <20050102203615.GL29332@holomorphy.com>
	 <20050102212427.GG2818@pclin040.win.tue.nl>
	 <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
	 <20050103153438.GF2980@stusta.de>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 16:59:02 +0100
Message-Id: <1104767943.4192.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 16:34 +0100, Adrian Bunk wrote:
> On Mon, Jan 03, 2005 at 10:18:47AM -0500, Rik van Riel wrote:
> > On Sun, 2 Jan 2005, Andries Brouwer wrote:
> > 
> > >You change some stuff. The bad mistakes are discovered very soon.
> > >Some subtler things or some things that occur only in special
> > >configurations or under special conditions or just with
> > >very low probability may not be noticed until much later.
> > 
> > Some of these subtle bugs are only discovered a year
> > after the distribution with some particular kernel has
> > been deployed - at which point the kernel has moved on
> > so far that the fix the distro does might no longer
> > apply (even in concept) to the upstream kernel...
> > 
> > This is especially true when you are talking about really
> > big database servers and bugs that take weeks or months
> > to trigger.
> 
> If at this time 2.8 was already released, the 2.8 kernel available at 
> this time will be roughly what 2.6 would have been under the current 
> development model, and 2.6 will be a rock stable kernel.


as long as more things get fixed than new bugs introduced (and that
still seems to be the case) things only improve in 2.6. 

The joint approach also has major advantages, even for quality:
All testing happens on the same codebase. 
Previously, the testing focus was split between the stable and unstable
branch, to the detriment of *both*.


