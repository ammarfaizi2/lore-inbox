Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281785AbRKQRdf>; Sat, 17 Nov 2001 12:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281788AbRKQRdZ>; Sat, 17 Nov 2001 12:33:25 -0500
Received: from ns.caldera.de ([212.34.180.1]:44206 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281785AbRKQRdQ>;
	Sat, 17 Nov 2001 12:33:16 -0500
Date: Sat, 17 Nov 2001 18:32:20 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: build-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mconfig 0.20 available
Message-ID: <20011117183220.A14033@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Keith Owens <kaos@ocs.com.au>, build-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011116173840.A15515@caldera.de> <16782.1005994611@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16782.1005994611@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Nov 17, 2001 at 09:56:51PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 09:56:51PM +1100, Keith Owens wrote:
> On Fri, 16 Nov 2001 17:38:40 +0100, 
> Christoph Hellwig <hch@caldera.de> wrote:
> >The mconfig release 0.20 is now available.
> >
> >Mconfig is a tool to configure the linux kernel, similar to
> >make {menu,x,}config, but written in C and with a proper yacc
> >parser.
> 
> Christoph, could you explain why this is being added now and how it
> compares to CML1 and/or CML2?

It's not added now - Michael started the development about 5 years ago,
in 1998 he stopped working on it.  In 1999 or 2001 I started hacking on
it, only adding what I needed.  Now I finally found the time to make a
formal release.
The tool mconfig parses CML1 rules, and does so _much_ more strictly
then any other parser.

> kbuild 2.[45] is completely agnostic about how .config and autoconf.h
> are built, the only requirement is that .config be internally
> consistent before it goes into the main build phase.  I don't care how
> .config is built, but I do want to understand why another version of
> CML is being developed.

The current cml1 scripts are _very_ ugly, and even if cml2 makes it in
2.5 (yes, I don't like it - but I don't have to decide it..) kernels
using cml1 will be around for a long time.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
