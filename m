Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131865AbQLJTfO>; Sun, 10 Dec 2000 14:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132346AbQLJTfD>; Sun, 10 Dec 2000 14:35:03 -0500
Received: from smtp5.libero.it ([193.70.192.55]:38619 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id <S131865AbQLJTen>;
	Sun, 10 Dec 2000 14:34:43 -0500
Message-ID: <3A33D3A7.FCD55F4@alsa-project.org>
Date: Sun, 10 Dec 2000 20:04:07 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net> <3A334F7C.3205A3DF@alsa-project.org> <20001210104413.A31257@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> 
> On Sun, Dec 10, 2000 at 10:40:12AM +0100, Abramo Bagnara wrote:
> > And this would be the only core_*.h files where this intention is
> > expressed?
> 
> Not at all.  See core_lca.h, jensen.h, core_cia.h, core_mcpcia.h.

I think you're confusing the issues: the only missing things from
core_t2.h are some defines to permit to it to work when CONFIG_ALPHA_T2
is defined.

The with or without mb() issue is handled in io.h and it's common for
all cores.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
