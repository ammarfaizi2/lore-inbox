Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbRLFAiS>; Wed, 5 Dec 2001 19:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbRLFAiI>; Wed, 5 Dec 2001 19:38:08 -0500
Received: from ns.suse.de ([213.95.15.193]:56069 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284890AbRLFAhw>;
	Wed, 5 Dec 2001 19:37:52 -0500
Date: Thu, 6 Dec 2001 01:37:51 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Rob Landley <landley@trommello.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011206001558.OQCD485.femail3.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33.0112060128420.18145-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Rob Landley wrote:

> > So anyone perfectly happy with an older distro that didn't
> > ship python2-and-whatever-else gets screwed when they want to
> > build a newer kernel. Nice.
>
> 1) Moving from 2.2->2.4, it wouldn't work at all without a newer compiler and
> newer modutils, and it really helped to have a C library and eight zillion
> other things upgraded.  So talking about what 2.6 will need that's an amazing
> red herring.

My comment was in regard to the subthread concerning the backport of
CML2 to 2.4 only. Not 2.5/2.6. Yes, tools need to be upgraded
OVER MAJOR VERSIONS. I was not debating that.

> 2) In terms of a 2.4 backport, if the old stuff isn't removed (the current
> garbage that does menuconfig et al), then who cares?

Anyone maintaining Config.in files. What you're proposing doubles the
amount of work to keep them up to date. Especially for out-of-tree code.

> It's also Marcelo's call.

Absolutely.

> It's not about the fact that reiserfs, ext3, and a new VM subsystem went
> into 2.4 but THIS is way too much

And did any of these require updated tools to build the kernel ?
No. I could take a kernel with these features, and build it on
a 6 month old distro.

> it's a group of people bitching about python because they don't like the
> concept of significant whitespace.

Crap. It's about not screwing over an installed userbase for a
feature that is nothing more than a "Nice to have" add-on for 2.4.

It's taken us long enough to get 2.4 where it is, hopefully the
days of things getting shovelled in enmasse are over.

>  Technically speaking, this is another variant of the good old
> indentation/coding style thread that just won't die.

I recommend "Kill by thread". Works wonders.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

