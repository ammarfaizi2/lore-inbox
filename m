Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278647AbRJ1TXH>; Sun, 28 Oct 2001 14:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278648AbRJ1TW5>; Sun, 28 Oct 2001 14:22:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7950 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278647AbRJ1TWn>; Sun, 28 Oct 2001 14:22:43 -0500
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 28 Oct 2001 19:29:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        zlatko.calusic@iskon.hr (Zlatko Calusic), axboe@suse.de (Jens Axboe),
        marcelo@conectiva.com.br (Marcelo Tosatti), linux-mm@kvack.org,
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33.0110281014300.7438-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 28, 2001 10:46:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xvcd-0000FM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes. My question is more: does the dpt366 thing limit the queueing some
> way?

Nope. The HPT366 is a bog standard DMA IDE controller. At least unless Andre
can point out something I've forgotten any behaviour seen on it should be
the same as seen on any other IDE controller with DMA support.

In practical terms that should mean you can obsere the same HPT366 problem
he does on whatever random IDE controller is on your desktop box

> But notice how that actually doesn't have anything to do with memory size,
> and makes your "scale by max memory" thing illogical.

When you are dealing with the VM limit which the limiter was originally
added for then it makes a lot of sense. When you want to use it solely for
other purposes then it doesnt.

