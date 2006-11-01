Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752394AbWKAVEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbWKAVEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbWKAVEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:04:32 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:63973 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1752394AbWKAVEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:04:31 -0500
Date: Wed, 1 Nov 2006 22:04:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Willy Tarreau <w@1wt.eu>, Valdis.Kletnieks@vt.edu, ray-gmail@madrabbit.org,
       "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061101210422.GB691@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com> <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu> <20061101063340.GA543@1wt.eu> <Pine.LNX.4.60.0611012123350.3736@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0611012123350.3736@poirot.grange>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 09:26:13PM +0100, Guennadi Liakhovetski wrote:
> > > On Tue, 31 Oct 2006 08:34:23 PST, Ray Lee said:
> > > > On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
> > > > > > At some point we should get rid of all the "politeness" warnings, just
> > > > > > because they can end up hiding the _real_ ones.
> > > > >
> > > > > Yay! Couldn't agree more. Does this mean you'll take patches for all the
> > > > > uninitialized variable crap from gcc 4.x ?
> > > > 
> > > > What would be useful in the short term is a tool that shows only the
> > > > new warnings that didn't exist in the last point release.
> 
> Would it be possible to create a new verbosity level like V=2 to hide 
> those "politeness" warnings so that by default everybody still would see 
> all of them, but those needing to track regressions could use it and only 
> see severe ones?

I suggest you try out make V=2 one day.
It does not compress warnings but tells you why something got rebuild.

	Sam
