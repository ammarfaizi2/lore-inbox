Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266439AbUFQKG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266439AbUFQKG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUFQKG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:06:27 -0400
Received: from witte.sonytel.be ([80.88.33.193]:1933 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266439AbUFQKG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:06:26 -0400
Date: Thu, 17 Jun 2004 12:06:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "David S. Miller" <davem@redhat.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: ip6_tables warning (was: Re: Linux 2.4.27-pre6)
In-Reply-To: <20040616183343.GA9940@logos.cnet>
Message-ID: <Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be>
References: <20040616183343.GA9940@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is not a new problem, but I never bothered to report it before:

| ip6_tables.c: In function `tcp_match':
| ip6_tables.c:1596: warning: implicit declaration of function `ipv6_skip_exthdr'
It needs to include <net/ipv6.h> to kill the warning.

Sorry, no patch, since my development machine is offline.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
