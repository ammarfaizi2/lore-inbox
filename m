Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUGHR5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUGHR5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUGHR5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:57:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63731 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263147AbUGHR5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:57:22 -0400
Date: Thu, 8 Jul 2004 19:57:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Jones <davej@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Miles Bader <miles@gnu.org>,
       "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sds@epoch.ncsc.mil, jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <20040708162357.GB19685@redhat.com>
Message-ID: <Pine.GSO.4.58.0407081956030.20943@waterleaf.sonytel.be>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
 <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
 <20040708162357.GB19685@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, Dave Jones wrote:
> On Thu, Jul 08, 2004 at 08:58:18AM -0700, Linus Torvalds wrote:
>
>  > Me, I don't accept the kind of entries the OCC accepts.
>
> drivers/char/drm/ disagrees 8-)

In that case... Linus, please remove those drivers, unless someone (DaveJ?)
converts them from OCC to LKC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
