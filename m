Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTFUXjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFUXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:39:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58126 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264124AbTFUXju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:39:50 -0400
Date: Sat, 21 Jun 2003 16:53:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, <alan@lxorguk.ukuu.org.uk>,
       <perex@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Isapnp warning
In-Reply-To: <20030621125111.0bb3dc1c.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Jun 2003, Andrew Morton wrote:
> 
> Meanwhile, let's do this:

I'd prefer the C99 thing, ie

	for (int i = xxx ...)

syntax. I know gcc-3.x supports it, maybe 2.96 does too? If so, we could
just add "-std=c99" or whatever, and start using that.

		Linus

