Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUIDMZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUIDMZe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUIDMZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:25:34 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:18694 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267372AbUIDMZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:25:27 -0400
Date: Sat, 4 Sep 2004 13:25:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904132512.B14904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904124658.A14628@infradead.org> <Pine.LNX.4.58.0409041253390.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409041253390.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 01:04:17PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:04:17PM +0100, Dave Airlie wrote:
> I've got nothing to do with Tungsten whatsoever, I've never met any of the
> other major DRI developers, my worries here is this is turning into a
> company issue, people keep mentioning Fedora this and that, Fedora is one
> distro, I happen to use it, lots of people I know dont.. it supports DRI
> on IGP and i915 in Fedora 3 Test only, a DRI snapshot works on FC1 and
> FC2 as well..

Fedota is only mentioned as an example because the development is so open
and I happen to see what's going on (I'm not using it myself at all).  I'm
pretty sure SuSE has/will have soon an update for i915, but it would requite
more work for me to find out.

> >
> > And how does taking random dri snapshots help you there?  The only sane way
> > to make that happen is to make sure it's in the various distro kernels ASAP.
> 
> Again what about distros that only do security upgrades in stable
> releases, I would like to give those people a chance to use their graphics
> cards, and the snapshots are not the only way, Intel have i915 Linux
> drivers on their site from TG, they work on most kernels/distros, I get a
> machine with i915 install Debian go to Intels website and download their
> drivers, it all works, now why do I have to compile a kernel again?

Okay, let's take Debian stable as an example.  How do you get an agpgart
that deals with the i915 into the 2.4.18 kernel woody ships?

You really want the whole software stack to support new hardware.  And for
that you best go to a kernel that's not from stoneage, either a new upstream
release or a maintained vendor kernel.
