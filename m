Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbQLRWcS>; Mon, 18 Dec 2000 17:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbQLRWcI>; Mon, 18 Dec 2000 17:32:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130584AbQLRWcD>; Mon, 18 Dec 2000 17:32:03 -0500
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
To: mikulas@artax.karlin.mff.cuni.cz
Date: Mon, 18 Dec 2000 22:02:41 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        pavel@suse.cz (Pavel Machek), sabre@nondot.org (Chris Lattner),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <Pine.LNX.3.96.1001218215008.1190A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Dec 18, 2000 10:46:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1488Mm-0006Hl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Imagine that kpiod is slow. try_to_swap_out returns 1 and pretends it
> freed something but it didn't. It just passed request to kpiod. There are
> no pages to be freed by shrink_mmap. do_try_to_swap_out calls swap_out
> several times, then returns. And this repeats again and again.

kpiod ceased to exist as of 2.2.19pre2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
