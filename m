Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbRL2A7r>; Fri, 28 Dec 2001 19:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286988AbRL2A72>; Fri, 28 Dec 2001 19:59:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28348 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S284280AbRL2A7P>;
	Fri, 28 Dec 2001 19:59:15 -0500
Date: Fri, 28 Dec 2001 19:59:14 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228195914.A14127@havoc.gtf.org>
In-Reply-To: <20011228161223.A19069@thyrsus.com> <Pine.LNX.4.33.0112281417410.23445-100000@penguin.transmeta.com> <20011228180557.B8216@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228180557.B8216@redhat.com>; from bcrl@redhat.com on Fri, Dec 28, 2001 at 06:05:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 06:05:57PM -0500, Benjamin LaHaise wrote:
> On Fri, Dec 28, 2001 at 02:27:37PM -0800, Linus Torvalds wrote:
> > and it's readable and probably trivially parseable into both the existing
> > format (ie some "find . -name '*.conf'" plus sed-scripts) and into cml2 or
> > whatever.
> 
> It's even doable within the .c file (and preferable for small drivers).  
> Something like:
> 
> 	/* mydriver.c .... header blah blah */
> 	config_requires(CONFIG_INET);
> 	config_option(CONFIG_MY_FAST_CHIP, "Help info for this");

If Linus is willing to buy into "driver.conf" there is no need to stuff
things into the source.  [my previous post made the mistaken assumption
that Linus would not like an additional metadata file like driver.conf]

A per-driver metadata file is IMHO clearly the preferred solution.

	Jeff


