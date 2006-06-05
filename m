Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932364AbWFEBGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWFEBGV (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFEBGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:06:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932364AbWFEBGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:06:20 -0400
Date: Sun, 4 Jun 2006 18:06:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: utsname/hostname
Message-Id: <20060604180618.02313245.akpm@osdl.org>
In-Reply-To: <20060604170218.f45a5302.rdunlap@xenotime.net>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060604170218.f45a5302.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 17:02:18 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> >  utsname virtualisation.  This doesn't seem very pointful as a standalone
> >  thing.  That's a general problem with infrastructural work for a very
> >  large new feature.
> > 
> >  So probably I'll continue to babysit these patches, unless someone can
> >  identify a decent reason why mainline needs this work.
> 
> Not a strong argument for mainline, but I have a patch to make
> <hostname> larger (up to 255 bytes, per POSIX).
>   http://www.xenotime.net/linux/patches/hostname-2617-rc5b.patch

My immediate reaction to that was to tell posix to go take a hike.  I mean,
sheesh.

> I can either update my hostname patch against mm/utsname.. or not.
> But I don't really want to see some/any patch blocked due to a patch
> in -mm being borderline "pointful," so how do we deal with this?

Well first we need to work out if there's any vague reason why we need to
mucky up our kernel by implementing this dopey spec.  If there is such a
reason then I guess I drop all the ustname patches and ask that they be
redone.  They're a bit straggly and a refactoring/rechanngelogging wouldn't
hurt.

