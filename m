Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVJRTHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVJRTHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVJRTHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:07:52 -0400
Received: from serv01.siteground.net ([70.85.91.68]:57784 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751156AbVJRTHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:07:51 -0400
Date: Tue, 18 Oct 2005 12:07:45 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018190745.GB4251@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org> <20051018001620.GD8932@localhost.localdomain> <200510181023.52074.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510181023.52074.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 10:23:51AM +0200, Andi Kleen wrote:
> On Tuesday 18 October 2005 02:16, Ravikiran G Thirumalai wrote:
> > On Mon, Oct 17, 2005 at 02:11:20PM -0700, Linus Torvalds wrote:
> > > On Mon, 17 Oct 2005, Andrew Morton wrote:
> > > > There seem to be a lot of proposed solutions floating about and I fear
> > > > that different people will try to fix this in different ways.  Do we
> > > > all agree that this patch is the correct solution to this problem, or
> > > > is something more needed?
> > >
> > > I think this will fix it.
> >
> > I just tried Yasunori-sans patch on our x460.  It doesn't fix the problem.
> 
> That's surprising. Can you post the full boot log? 

I'd already posted that... Here is the link
http://marc.theaimsgroup.com/?l=linux-kernel&m=112959469914681&w=2

> The nodes should be really in order. Maybe we need to sort the SRAT first.

I don't understand this comment.  I thought Yasunori-san's patch did not
require pgdats to be in any order..  Anywayz, the x460 nodes _are_ in proper
order.

Thanks,
Kiran
