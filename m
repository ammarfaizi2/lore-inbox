Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287116AbRL2D6i>; Fri, 28 Dec 2001 22:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287113AbRL2D6S>; Fri, 28 Dec 2001 22:58:18 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17343 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S287114AbRL2D6H>;
	Fri, 28 Dec 2001 22:58:07 -0500
Date: Fri, 28 Dec 2001 22:58:03 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228225803.A7801@havoc.gtf.org>
In-Reply-To: <20011228161603.B5397@havoc.gtf.org> <7850.1009589209@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7850.1009589209@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Dec 29, 2001 at 12:26:49PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 12:26:49PM +1100, Keith Owens wrote:
> On Fri, 28 Dec 2001 16:16:03 -0500, 
> Legacy Fishtank <garzik@havoc.gtf.org> wrote:
> >I think one thing to note is that dependencies is that if you are smart
> >about it, dependencies -really- do not even change when your .config
> >changes.
> >
> >What about a system where Linus runs "make deps" -once- before he
> >releases a tarball.  This in turn generates dependency information
> >(perhaps not in purely make format) which includes 'ifdef CONFIG_xxx'
> >information embedded within.  We know that make can support ifeq
> >CONFIG_xxx for example...
> 
> Then people apply patches and break.

s/break/update dependencies/

I assumed this was blindingly obvious, but I guess not.

	Jeff


