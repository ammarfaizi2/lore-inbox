Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287037AbRL2B1Y>; Fri, 28 Dec 2001 20:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287019AbRL2B1O>; Fri, 28 Dec 2001 20:27:14 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:8976 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287038AbRL2B1E>;
	Fri, 28 Dec 2001 20:27:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Legacy Fishtank <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 16:16:03 CDT."
             <20011228161603.B5397@havoc.gtf.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 12:26:49 +1100
Message-ID: <7850.1009589209@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 16:16:03 -0500, 
Legacy Fishtank <garzik@havoc.gtf.org> wrote:
>I think one thing to note is that dependencies is that if you are smart
>about it, dependencies -really- do not even change when your .config
>changes.
>
>What about a system where Linus runs "make deps" -once- before he
>releases a tarball.  This in turn generates dependency information
>(perhaps not in purely make format) which includes 'ifdef CONFIG_xxx'
>information embedded within.  We know that make can support ifeq
>CONFIG_xxx for example...

Then people apply patches and break.  Please read the list of mkdep
bugs before suggesting partial fixes.

http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2,
makefile-2.5_make_dep.html.  I want a system that fixes _all_ the bugs,
not just some of them.

