Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130128AbQLJVUF>; Sun, 10 Dec 2000 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLJVTz>; Sun, 10 Dec 2000 16:19:55 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:7440 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S130401AbQLJVTt>; Sun, 10 Dec 2000 16:19:49 -0500
Date: Sun, 10 Dec 2000 12:49:18 -0800
From: Richard Henderson <rth@twiddle.net>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
Message-ID: <20001210124918.A31383@twiddle.net>
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net> <3A334F7C.3205A3DF@alsa-project.org> <20001210104413.A31257@twiddle.net> <3A33D3A7.FCD55F4@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A33D3A7.FCD55F4@alsa-project.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 08:04:07PM +0100, Abramo Bagnara wrote:
> ... the only missing things from core_t2.h are some defines to
> permit to it to work when CONFIG_ALPHA_T2 is defined.

Have you tried it?  I did.  It works fine.

What _is_ defined in asm/core_t2.h is enough for alpha/lib/io.c to
define out of line functions that asm/io.h then uses.

This same mechanism is used on cia, mcpcia, lca, and jensen.
It has been in place in just this fashion since 2.1.something.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
