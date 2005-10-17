Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVJQRwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVJQRwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVJQRwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:52:41 -0400
Received: from serv01.siteground.net ([70.85.91.68]:12935 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750747AbVJQRwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:52:41 -0400
Date: Mon, 17 Oct 2005 10:52:31 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org, clameter@engr.sgi.com
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017175231.GA4959@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de> <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org> <200510171740.57614.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510171740.57614.ak@suse.de>
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

On Mon, Oct 17, 2005 at 05:40:56PM +0200, Andi Kleen wrote:
> On Monday 17 October 2005 17:27, Linus Torvalds wrote:
> > On Mon, 17 Oct 2005, Andi Kleen wrote:
> > ...
> > Argh. Which one should I pick? The NODE(0) one looks simpler, but is it
> > sufficient for now in practice (with the real one going into 2.6.14+)?
> >
> > 		Linus
> 
> First this problem is definitely not critical. AFAIK it only happens on 
> scalex's unreleased machines. Intel NUMA x86 machines are really rare
				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
No they are not.  IBM X460s are generally available machines and  the bug
affects those boxes. How can there be a major kernel release which is known
to have breakage??  

Maybe someone with access to ia64 NUMA boxen can check if the NODE(0)
solution works (and does not break anything) on ia64?  Chrisoph, can you help?

Thanks,
Kiran
