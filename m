Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287055AbRL2BoF>; Fri, 28 Dec 2001 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287054AbRL2Bnq>; Fri, 28 Dec 2001 20:43:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36622 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287053AbRL2Bni>; Fri, 28 Dec 2001 20:43:38 -0500
Subject: Re: State of the new config & build system
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 29 Dec 2001 01:53:17 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        garzik@havoc.gtf.org (Legacy Fishtank), linux-kernel@vger.kernel.org,
        lm@bitmover.com (Larry McVoy), esr@thyrsus.com (Eric S. Raymond),
        davej@suse.de (Dave Jones), marcelo@conectiva.com.br (Marcelo Tosatti),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <7861.1009589244@ocs3.intra.ocs.com.au> from "Keith Owens" at Dec 29, 2001 12:27:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K8gY-0002fQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dependency problem, any solution that does not fix _all_ 9 problems in
> http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2,
> makefile-2.5_make_dep.html is not a complete fix.

All well and good but "takes 100% longer" is number 10 on that list which
you missed off, and the same argument holds for that.

> but there is one problem that is inherently unfixable.  make dep is a
> manual process so it relies on users knowing when they have to rerun
> make dep AND THEY DON'T DO IT!  Please do not say "I always run make

So automate running make dep.

> Linus, you have a choice between a known broken build system and a

So broken its worked for say 5 years without major problem

> ps. I don't want mail discussing individual bug fixes to mkdep.  Code
>     that does not fix _all_ 9 bugs listed in makefile-2.5_make_dep.html
>     is pointless.

And bug number 10 you didnt mention
