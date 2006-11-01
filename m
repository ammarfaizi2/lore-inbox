Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992803AbWKAU0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992803AbWKAU0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992805AbWKAU0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:26:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:18662 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S2992803AbWKAU0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:26:16 -0500
X-Authenticated: #20450766
Date: Wed, 1 Nov 2006 21:26:13 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Willy Tarreau <w@1wt.eu>
cc: Valdis.Kletnieks@vt.edu, ray-gmail@madrabbit.org,
       "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
In-Reply-To: <20061101063340.GA543@1wt.eu>
Message-ID: <Pine.LNX.4.60.0611012123350.3736@poirot.grange>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org>
 <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
 <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu> <20061101063340.GA543@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Tue, 31 Oct 2006 08:34:23 PST, Ray Lee said:
> > > On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
> > > > > At some point we should get rid of all the "politeness" warnings, just
> > > > > because they can end up hiding the _real_ ones.
> > > >
> > > > Yay! Couldn't agree more. Does this mean you'll take patches for all the
> > > > uninitialized variable crap from gcc 4.x ?
> > > 
> > > What would be useful in the short term is a tool that shows only the
> > > new warnings that didn't exist in the last point release.

Would it be possible to create a new verbosity level like V=2 to hide 
those "politeness" warnings so that by default everybody still would see 
all of them, but those needing to track regressions could use it and only 
see severe ones?

Thanks
Guennadi
---
Guennadi Liakhovetski
