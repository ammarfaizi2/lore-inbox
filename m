Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTEMPiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTEMPiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:38:03 -0400
Received: from havoc.daloft.com ([64.213.145.173]:41171 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261754AbTEMPiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:38:01 -0400
Date: Tue, 13 May 2003 11:50:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513155047.GA30944@gtf.org>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513163854.A27407@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513163854.A27407@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:38:54PM +0100, Christoph Hellwig wrote:
> On Tue, May 13, 2003 at 02:57:08PM +0100, Alan Cox wrote:
> > > - ACPI needs the relax patches merging to work on lots of laptops
> > 
> > Working in 2.4.21-ac, Toshiba cheap laptops now run a treat. Forward
> > port looks like a patch command
> > 
> > 
> > Other items:
> > 
> > PC9800 is not fully merged - most of this I think is 2.7 stuff but a few
> > bits might be 2.6 candidate
> > 
> > SH3/SH3-64 need resynching, as do some other ports. No impact on
> > mainstream platforms hopefully
> 
> That brings up another issue:  what ports do regularly work with 2.5
> mainline?  I've been working with David to get all those core changes ia64
> needs (and there's still a lot) sorted out so maybe 2.6 will work out of
> the box.  I guess some other arches (parisc, mips?) will need similar
> work.

mips definitely needs work.  I don't know that there exists a working
2.5 mips port.

I told Ralf I would work on getting it booting on my Indy, and have been
slowly working through that.  There is also some mips work in the
linux-mips cvs tree.

That's definitely a "todo"

	Jeff



