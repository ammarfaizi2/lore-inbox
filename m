Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275430AbTHIWQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275431AbTHIWQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:16:14 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:29724 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S275430AbTHIWQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:16:10 -0400
Date: Sun, 10 Aug 2003 01:15:54 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       gibbs@scsiguy.com, alan@redhat.com
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1, aic7xxx-6.2.36: solid hangs)
Message-ID: <20030809221554.GC150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, gibbs@scsiguy.com, alan@redhat.com
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030808125502.GB150921@niksula.cs.hut.fi> <20030809201951.GP16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809201951.GP16091@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 10:19:51PM +0200, you [Adrian Bunk] wrote:
> On Fri, Aug 08, 2003 at 03:55:02PM +0300, Ville Herva wrote:
> > 
> > Which brings me to the question: which gcc version is considered most stable
> > for compiling 2.4.x these days?
> >...
> > This seems to suggest 2.96-85 would be more stable than gcc-3.2.1-2. Is this
> > the case?
> >...
> 
> 2.95.3 and the (unofficial) 2.96 are the best compilers for 2.4 .
> 
> In most cases 3.2.1 will give you a working kernel, but if you need
> maximum stablity don't use gcc 3.x for compiling kernel 2.4 .

I'm surely aiming for stability, yeah ;).

2.96-85 produces a kernel that hangs (though it's not proven it's gcc's
fault) -- the one compiled with gcc-3.2.1-2 hasn't hung yet. I guess I
should at least use the latest errata version if I go with 2.96...


-- v --

v@iki.fi
