Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272163AbRIIQnw>; Sun, 9 Sep 2001 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272544AbRIIQnn>; Sun, 9 Sep 2001 12:43:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22021 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272163AbRIIQnZ>; Sun, 9 Sep 2001 12:43:25 -0400
Subject: Re: Purpose of the mm/slab.c changes
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 9 Sep 2001 17:47:12 +0100 (BST)
Cc: manfred@colorfullife.com (Manfred Spraul),
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0109090925080.14365-100000@penguin.transmeta.com> from "Linus Torvalds" at Sep 09, 2001 09:25:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15g7jk-0007Rb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > doesn't matter which free page is used first/last.
> 
> You're full of crap.
> LIFO is obviously superior due to cache re-use.

Interersting question however. On SMP without sufficient per CPU slab caches
is tht still the case ?
