Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284302AbRL1XD2>; Fri, 28 Dec 2001 18:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284289AbRL1XDI>; Fri, 28 Dec 2001 18:03:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284258AbRL1XC7>; Fri, 28 Dec 2001 18:02:59 -0500
Subject: Re: State of the new config & build system
To: esr@thyrsus.com
Date: Fri, 28 Dec 2001 23:13:00 +0000 (GMT)
Cc: garzik@havoc.gtf.org (Legacy Fishtank),
        torvalds@transmeta.com (Linus Torvalds), davej@suse.de (Dave Jones),
        esr@snark.thyrsus.com (Eric S. Raymond),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228154537.E17774@thyrsus.com> from "Eric S. Raymond" at Dec 28, 2001 03:45:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K6BQ-00029u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd be happy to take another swing at this problem once the kbuild-2.5/CML2
> transition is done.  But I don't think we should let it block us from
> having the good results we can get from that change.

It would certainly fit nicely with the existing metadata. We already rip out
code comments via kernel-doc, and extending it to rip out

	-	Help text
	-	Web site
	-	Version information
	-	Man page for the driver
	-	Module options

etc, shouldn't be too challenging. Ok so kernel-doc is in perl and ugly perl
but if someone hates it enough to rewrite it in python thats a win too 8)

Alan
