Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbQLJKLO>; Sun, 10 Dec 2000 05:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130374AbQLJKLE>; Sun, 10 Dec 2000 05:11:04 -0500
Received: from smtp3.libero.it ([193.70.192.53]:28849 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S129960AbQLJKKw>;
	Sun, 10 Dec 2000 05:10:52 -0500
Message-ID: <3A334F7C.3205A3DF@alsa-project.org>
Date: Sun, 10 Dec 2000 10:40:12 +0100
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
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> 
> On Sat, Dec 09, 2000 at 09:43:00AM +0100, Abramo Bagnara wrote:
> > alpha-mb-2.4.diff add missing defines from core_t2.h for non generic
> > kernel (against 2.4.0test11)
> 
> These are not "missing".  They are intentionally not present
> so that stuff will be done out of line.

And this would be the only core_*.h files where this intention is
expressed?

It's hard to believe, without you explain why ;-)

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
