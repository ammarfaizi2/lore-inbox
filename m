Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUIKVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUIKVQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUIKVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:13:13 -0400
Received: from [217.132.60.104] ([217.132.60.104]:6022 "EHLO localhost")
	by vger.kernel.org with ESMTP id S268326AbUIKVIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:08:44 -0400
Date: Sun, 12 Sep 2004 01:11:28 +0300
From: SashaK <sashak@smlink.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97
 patch)
Message-ID: <20040912011128.031f804a@localhost>
In-Reply-To: <200409111850.i8BIowaq013662@harpo.it.uu.se>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 20:50:58 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> No, I meant the 'slamr' kernel driver module, which is
> built from a big binary-only library (amrlibs.o) and
> a small amount of kernel glue source code. As long as
> amrlibs.o is distributed only as a 32-bit x86 binary,
> I won't be able to use it with a 64-bit amd64 kernel.

This is exactly that was discussed - 'slamr' is going to be replaced by
ALSA drivers. I don't know which modem you have, but recent ALSA
driver (CVS version) already supports ICH, SiS, NForce (snd-intel8x0m),
ATI IXP (snd-atiixp-modem) and VIA (snd-via82xx-modem) AC97 modems.

Sasha.
