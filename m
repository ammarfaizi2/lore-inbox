Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTLBOUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLBOUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:20:23 -0500
Received: from [160.216.153.99] ([160.216.153.99]:55819 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S262131AbTLBOUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:20:14 -0500
Date: Tue, 2 Dec 2003 15:21:54 -0500 (EST)
From: Tomas Konir <moje@vabo.cz>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
In-Reply-To: <20031202135423.GB13388@conectiva.com.br>
Message-ID: <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
 <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de>
 <20031202120315.GK13388@conectiva.com.br> <Pine.LNX.4.58.0312021402360.17892@moje.vabo.cz>
 <20031202131512.GU13388@conectiva.com.br> <Pine.LNX.4.58.0312021433360.8417@moje.vabo.cz>
 <20031202135423.GB13388@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:

> Em Tue, Dec 02, 2003 at 02:38:54PM -0500, Tomas Konir escreveu:
> > On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
> > 
> > > Em Tue, Dec 02, 2003 at 02:06:34PM -0500, Tomas Konir escreveu:
> > > > On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
> > > > 
> > > > > Em Tue, Dec 02, 2003 at 12:54:36PM +0100, Ionut Georgescu escreveu:
> > > > > > I can only second that. We've been using XFS here since the days of
> > > > > > 2.4.0-testxx and the only problems we've had were sitting between the
> > > > > > chair and the keyboard.
> > > > > 
> > > > > So if there is no problems at all using it as a patch why add this to a
> > > > > kernel that is phasing out?
> > > > 
> > > > Because me and others are wasting our time when merging xfs with other 
> > > > patches such as grsecurity. XFS in kernel can save our time. The question 
> > > > is, that if JFS and other FS's are in kernel, why not XFS ?
> > > 
> > > Why not ReiserFS4? Or DRBD? Or... :-)
> > 
> > ReiserFS4 is stable ? very new information for me.
> 
> Well, some people may well consider :-) But yes, this was my fault, I should
> have just mentioned DRBD and other patches in similar situation, just look
> at any recent 2.4 rpm from any distro.

Distro kernels contains many features, but a lot of bloat :-(
no one pure distro kernel can be used as server kernel.
(only my opinion)

> 
> > > Like I was discussing with Marcelo: if he stated that 2.4 will get in deep
> > > freeze, it means that the external patches for this kernel will not have to
> > > be maintained, or the maintainance will be very very small, and related to
> > > things that are _outside_ the kernel.
> > 
> > 2.2 external patches are not related to other's now.
> 
> 2.2?
> 
> > Why 2.4 patches will be ?
> 
> Havent you mentioned grsecurity?

grsecurity is good example. I have to merge cca 10 rejects, when adding to 
linux-xfs kernel.

> 
> > This discussion is not about unstable testing feature, but about rock 
> > stable filesystem, used by many. Including in kernel can help without 
> 
> It is about adding a new feature, whatever is the opinion of people about
> its stability or not, in a kernel that is being phased out.

agree
but this feature is wanted by many and still rejected without serious 
reasons.

> > stability compromise. I think, that there is no reliable argument to 
> > not include XFS into main kernel.
> 
> But it is included, in 2.6, where it seems to be showing problems, as
> mentioned by Linus some days ago, I for one was using it and stopped, switched
> to ext3 and have had no problems since.

2.6 is still unstable now. I'm using -test10 on my workstation, but it 
takes minimally an half year to use it on server. I can't use ext3 on 
server, because of missing features such as ACL, dump (with acl's), 
built in qouta and for last much different speed on SMP machine.

> 
> But hey, take this discussion to lkml, there more people will be able to
> discuss with us :-)

roger
cc: to linux-kernel

	MOJE

-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

