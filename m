Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTLBSxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTLBSxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:53:13 -0500
Received: from havoc.gtf.org ([63.247.75.124]:20116 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264322AbTLBSxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:53:09 -0500
Date: Tue, 2 Dec 2003 13:49:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg Stark <gsstark@mit.edu>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202184914.GA7839@gtf.org>
References: <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com> <20031202055852.GP1566@mis-mike-wstn.matchmail.com> <87zneb9o5q.fsf@stark.dyndns.tv> <20031202174048.GQ1566@mis-mike-wstn.matchmail.com> <20031202180458.GC1990@gtf.org> <20031202184648.GU1566@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202184648.GU1566@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 10:46:48AM -0800, Mike Fedyk wrote:
> On Tue, Dec 02, 2003 at 01:04:58PM -0500, Jeff Garzik wrote:
> > On Tue, Dec 02, 2003 at 09:40:48AM -0800, Mike Fedyk wrote:
> > > There are PATA drives that do TCQ too, but you have to look for that feature
> > > specifically.  IDE TCQ is in 2.6, but is still experemental.  I think Jens
> > > Axboe was the one working on it IIRC.  He would have more details.
> > 
> > Let us distinguish three types of TCQ:
> > 1) PATA drive-side TCQ (now called "legacy TCQ")
> > 2) Controller-side TCQ
> > 3) SATA drive/controller-side TCQ ("first party DMA")
> > 
> > libata will never support #1, which is what 2.6 supports in experimental
> > option.
> 
> An experemental option with the ide layer, not libata, right?

Correct.


> > libata will support #2 very soon, and will support #3 when hardware is
> > available.
> > 
> 
> If you have Controller-side TCQ, then will it work with any IDE PATA/SATA
> drive?

Yes.

	Jeff



