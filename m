Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268649AbRGZShB>; Thu, 26 Jul 2001 14:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268648AbRGZSgv>; Thu, 26 Jul 2001 14:36:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13072 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268649AbRGZSgi>; Thu, 26 Jul 2001 14:36:38 -0400
Subject: Re: user-mode port 0.44-2.4.7
To: jh@suse.cz (Jan Hubicka)
Date: Thu, 26 Jul 2001 19:35:44 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), torvalds@transmeta.com (Linus Torvalds),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        cfriesen@nortelnetworks.com (Chris Friesen),
        jdike@karaya.com (Jeff Dike),
        user-mode-linux-user@lists.sourceforge.net (user-mode-linux-user),
        linux-kernel@vger.kernel.org (linux-kernel), jh@suse.cz (Jan Hubicka)
In-Reply-To: <20010726202844.K9601@atrey.karlin.mff.cuni.cz> from "Jan Hubicka" at Jul 26, 2001 08:28:44 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ppz6-0004I8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> and blame gcc developers for breaking it, or stay in the unsafe ground
> and fix kernel each time gcc will introduce new nasty optimizations.
> This may become tricky later - for instance as making kernel codebase
> -fstrict-aliasing ready.

Until the C language improves its ability to describe aliasing safety I
don't think its going to be practical to fix the issue. I've seen patches to
make slhc.c strict aliasing safe for example, and they are too ugly to live
