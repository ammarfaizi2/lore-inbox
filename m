Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272692AbRHaN6c>; Fri, 31 Aug 2001 09:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272694AbRHaN6V>; Fri, 31 Aug 2001 09:58:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20489 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272692AbRHaN6D>; Fri, 31 Aug 2001 09:58:03 -0400
Subject: Re: Athlon doesn't like Athlon optimisation?
To: goemon@anime.net (Dan Hollis)
Date: Fri, 31 Aug 2001 15:00:53 +0100 (BST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        david@digitalaudioresources.org (David Hollister),
        jan@gondor.com (Jan Niehusmann), linux-kernel@vger.kernel.org,
        rgooch@atnf.csiro.au
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net> from "Dan Hollis" at Aug 30, 2001 09:20:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15coqr-0003DR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what happens when someone is able to duplicate the problem on say AMD
> 760MP chipset with registered ECC PC2100 ram and 450W power supply?
> 
> Not to say it has happened yet (I havent got my dual Tyan Tiger MP yet :-)
> but where would the finger start pointing then?

That would make it a lot more complex. There were a few cases much earlier
on with AMD chipset lockups but those have been cured (and were an Athlon
processor errata where a prefetch of an uncacheable line made a very very
nasty mess).

Alan
