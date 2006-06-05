Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932395AbWFEDHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWFEDHu (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 23:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWFEDHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 23:07:49 -0400
Received: from xenotime.net ([66.160.160.81]:41960 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932395AbWFEDHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 23:07:49 -0400
Date: Sun, 4 Jun 2006 20:10:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: utsname/hostname
Message-Id: <20060604201036.7470c043.rdunlap@xenotime.net>
In-Reply-To: <20060604180618.02313245.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060604170218.f45a5302.rdunlap@xenotime.net>
	<20060604180618.02313245.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 18:06:18 -0700 Andrew Morton wrote:

> On Sun, 4 Jun 2006 17:02:18 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > >  utsname virtualisation.  This doesn't seem very pointful as a standalone
> > >  thing.  That's a general problem with infrastructural work for a very
> > >  large new feature.
> > > 
> > >  So probably I'll continue to babysit these patches, unless someone can
> > >  identify a decent reason why mainline needs this work.
> > 
> > Not a strong argument for mainline, but I have a patch to make
> > <hostname> larger (up to 255 bytes, per POSIX).
> >   http://www.xenotime.net/linux/patches/hostname-2617-rc5b.patch
> 
> My immediate reaction to that was to tell posix to go take a hike.  I mean,
> sheesh.

well thanks for finally replying then.
That's my reaction to some other patches (in -mm) as well
(not that it matters).

> > I can either update my hostname patch against mm/utsname.. or not.
> > But I don't really want to see some/any patch blocked due to a patch
> > in -mm being borderline "pointful," so how do we deal with this?
> 
> Well first we need to work out if there's any vague reason why we need to
> mucky up our kernel by implementing this dopey spec.  If there is such a
> reason then I guess I drop all the ustname patches and ask that they be
> redone.  They're a bit straggly and a refactoring/rechanngelogging wouldn't
> hurt.

Fixing the changelog is easy.  What refactoring do you mean?

---
~Randy
