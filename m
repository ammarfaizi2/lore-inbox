Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284176AbRL1WcW>; Fri, 28 Dec 2001 17:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284195AbRL1WcM>; Fri, 28 Dec 2001 17:32:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10766 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284176AbRL1WcE>; Fri, 28 Dec 2001 17:32:04 -0500
Date: Fri, 28 Dec 2001 14:29:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: State of the new config & build system
In-Reply-To: <20011228170840.A20254@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0112281429010.23445-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Eric S. Raymond wrote:
>
> OK.  Background, for anyone who doesn't know this: the equivalent of
> Configure.help in CML2 is the symbols.cml file.  It's actually generated
> fat CML2 installation time from Configure.help.

Oh, crap, _another_ magic global file.

Eric, this is the _wrong_approach_. I want /local/ files, not global ones.

		Linus

