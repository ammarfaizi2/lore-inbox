Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUFPUyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUFPUyC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUFPUyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:54:02 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1193 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264836AbUFPUty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:49:54 -0400
Date: Wed, 16 Jun 2004 13:49:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040616204953.GG24479@smtp.west.cox.net>
References: <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org> <20040615204616.E7666@flint.arm.linux.org.uk> <20040615205557.GK2310@mars.ravnborg.org> <20040615220646.I7666@flint.arm.linux.org.uk> <20040616194919.GA4384@mars.ravnborg.org> <20040616200824.GF24479@smtp.west.cox.net> <20040616205415.GA2096@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616205415.GA2096@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 10:54:16PM +0200, Sam Ravnborg wrote:
> On Wed, Jun 16, 2004 at 01:08:24PM -0700, Tom Rini wrote:
> > On Wed, Jun 16, 2004 at 09:49:19PM +0200, Sam Ravnborg wrote:
> > 
> > > What about this much simpler approach?
> > > 
> > > One extra assignment for each architecture added to get access to the
> > > kernel image (at least the default one) for that architecture.
> > 
> > Will it also include the 'vmlinux' ?
> Today the rpm does not include vmlinux - but thats a trivial thing to add.
> I assume the same is tru for .deb
> tar.gz is not written yet...
> 
> >  And would I be right in assuming
> > that it will accept (a) globs and (b) can be defined inside of
> > arch/ppc/boot/foo/Makefile ?
> Yes, and yes.

Then I think I can live with it, and fix it up to be correct on PPC32
once it's in.

-- 
Tom Rini
http://gate.crashing.org/~trini/
