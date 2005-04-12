Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVDLWx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVDLWx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVDLWur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:50:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:23429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262586AbVDLWrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:47:25 -0400
Date: Tue, 12 Apr 2005 15:49:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <m33btvhbnr.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.58.0504121543360.4501@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org>
 <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org>
 <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <m33btvhbnr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2005, Krzysztof Halasa wrote:
> 
> Does that mean that the 64 K changes imported from bk would take ~ 3 GB?
> Is that real?

That's a _guess_. 

> Have to tried to import it?

It would take days.

> I'm going to import the CVS data (with cvsps) - as the CVS "misses" half
> the changes, the resulting archive should be half in size too?

No. The CVS archive is going to be almost the same size. BKCVS gets about 
98% of all the data. It just doesn't show the complex merge graphs, but 
those are "small" in comparison.

> I don't know how much space did bk use, but 3 GB for the full history
> is reasonable for most people, isn't it? Especially that one can purge
> older data.

I think it's entirely reasonable, yes. But I may be off by an order of
magnitude. I based the 3GB on estimating form the sparse tree, but I
wasn't being too careful. Andrew estimated 2GB per year (at our current
historical rate of changes) based on my merge with him. So it's in that 
general range of 3-6GB, I htink.

		Linus
