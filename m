Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266819AbUGLNXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUGLNXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUGLNXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:23:14 -0400
Received: from witte.sonytel.be ([80.88.33.193]:1971 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266819AbUGLNXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:23:09 -0400
Date: Mon, 12 Jul 2004 15:23:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: struct_cpy() and kAFS (was: Re: Linux 2.6.8-rc1)
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0407121519380.17199@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Linus Torvalds wrote:
> David Howells:
>   o kAFS automount support

After this change, all archs need to provide struct_cpy() to make AFS compile,
while currently only ia32 and amd64 provide it.

Since its implementation is quite generic, perhaps it can be moved/added to
<linux/string.h>?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
