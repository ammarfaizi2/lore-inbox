Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284282AbRL1VTH>; Fri, 28 Dec 2001 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284272AbRL1VSr>; Fri, 28 Dec 2001 16:18:47 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34743 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S284164AbRL1VSj>;
	Fri, 28 Dec 2001 16:18:39 -0500
Date: Fri, 28 Dec 2001 16:16:03 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@ocs.com.au>, Larry McVoy <lm@bitmover.com>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228161603.B5397@havoc.gtf.org>
In-Reply-To: <18619.1009503350@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0112282035020.2889-100000@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112282035020.2889-100000@vaio>; from kai@tp1.ruhr-uni-bochum.de on Fri, Dec 28, 2001 at 09:56:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think one thing to note is that dependencies is that if you are smart
about it, dependencies -really- do not even change when your .config
changes.

What about a system where Linus runs "make deps" -once- before he
releases a tarball.  This in turn generates dependency information
(perhaps not in purely make format) which includes 'ifdef CONFIG_xxx'
information embedded within.  We know that make can support ifeq
CONFIG_xxx for example...

	Jeff



