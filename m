Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTFUXyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFUXyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:54:32 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:32775 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264828AbTFUXy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:54:27 -0400
Date: Sat, 21 Jun 2003 21:11:01 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       alan@lxorguk.ukuu.org.uk, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622001101.GB10801@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 21, 2003 at 04:53:32PM -0700, Linus Torvalds escreveu:
> 
> On Sat, 21 Jun 2003, Andrew Morton wrote:
> > 
> > Meanwhile, let's do this:
> 
> I'd prefer the C99 thing, ie
> 
> 	for (int i = xxx ...)
> 
> syntax. I know gcc-3.x supports it, maybe 2.96 does too? If so, we could
> just add "-std=c99" or whatever, and start using that.

Humm, I'd love to do that, i.e. to make gcc 3 required, lots of good stuff
like this one, anonymous structs, etc, etc, lots of stuff could be done in
an easier way, but are we ready to abandon gcc 2.95.*? Can anyone confirm
if gcc 2.96 accepts this?

- Arnaldo
