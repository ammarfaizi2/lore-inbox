Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131740AbQLVQtT>; Fri, 22 Dec 2000 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131964AbQLVQtA>; Fri, 22 Dec 2000 11:49:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21267 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131740AbQLVQs4>; Fri, 22 Dec 2000 11:48:56 -0500
Date: Fri, 22 Dec 2000 17:18:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: test13-pre4
Message-ID: <20001222171816.A1752@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com> <m149Uj9-000OXLC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m149Uj9-000OXLC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Fri, Dec 22, 2000 at 05:07:27PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 05:07:27PM +0100, Arjan van de Ven wrote:
> In article <3A43506B.6CEF84BB@eyal.emu.id.au> you wrote:
> > Linus Torvalds wrote:
> >>  - pre4:
> >>    - Andrea Arkangeli: update to LVM-0.9
> 
> > lvm.c: In function `lvm_do_create_proc_entry_of_lv':
> 
> [snip]
> 
> Hi,
> 
> The patch below fixes this.

I prefer my one that also kills the bogus check for CONFIG_PROC_FS introducing
a dependency on CONFIG_PROC_FS in config.in.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
