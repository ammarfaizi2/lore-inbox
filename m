Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281921AbRL1WUm>; Fri, 28 Dec 2001 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281966AbRL1WUc>; Fri, 28 Dec 2001 17:20:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53005 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281921AbRL1WUV>; Fri, 28 Dec 2001 17:20:21 -0500
Date: Fri, 28 Dec 2001 14:17:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Legacy Fishtank <garzik@havoc.gtf.org>
cc: <linux-kernel@vger.kernel.org>, Keith Owens <kaos@ocs.com.au>,
        Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <20011228161603.B5397@havoc.gtf.org>
Message-ID: <Pine.LNX.4.33.0112281416290.23445-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Legacy Fishtank wrote:
>
> I think one thing to note is that dependencies is that if you are smart
> about it, dependencies -really- do not even change when your .config
> changes.

Absolutely. I detest "gcc -MD", exactly because it doesn't get this part
right. "mkdep.c" gets this _right_.

		Linus

