Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276937AbRJHPZf>; Mon, 8 Oct 2001 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276935AbRJHPZZ>; Mon, 8 Oct 2001 11:25:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25136 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276937AbRJHPZT>; Mon, 8 Oct 2001 11:25:19 -0400
Date: Mon, 8 Oct 2001 17:24:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Ingo Molnar <mingo@elte.hu>,
        jamal <hadi@cyberus.ca>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011008172450.A726@athlon.random>
In-Reply-To: <Pine.LNX.3.96.1011008100030.13807A-100000@mandrakesoft.mandrakesoft.com> <E15qc5N-0000p5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15qc5N-0000p5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 08, 2001 at 04:12:53PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 04:12:53PM +0100, Alan Cox wrote:
> "Driver killed because the air bag enable is off by default and only
> mentioned on page 87 of the handbook in a footnote"

Nobody suggested to not add "an airbag" by default.

Infact the polling isn't an airbag at all, when you poll you're flying
so you never need an airbag at all, only when you're on the ground you
may need the airbag.

Another thing I said recently is that the hardirq airbag have nothing to
do with softirqs, and that's right. Patch messing the softirq logic in
function of the hardirq airbag are just totally broken or at least
confusing because incidentally merged together by mistake.

Andrea
