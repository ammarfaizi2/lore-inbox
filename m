Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbREaVix>; Thu, 31 May 2001 17:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbREaVin>; Thu, 31 May 2001 17:38:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263238AbREaVi3>; Thu, 31 May 2001 17:38:29 -0400
Subject: Re: [PATCH] net #6
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 31 May 2001 22:35:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        jgarzik@mandrakesoft.com (Jeff Garzik), Philip.Blundell@pobox.com,
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010531002437.A21681@bug.ucw.cz> from "Pavel Machek" at May 31, 2001 12:24:37 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155a6U-00084l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > They are done this way to get good non SMP performance. Your changes would
> > ruin that.
> 
> Maybe macro "spin_lock_irqsave_on_smp()" would be good idea? These
> ifdefs look ugly. Maybe local to driver, maybe even global.

I had that argument with Linus about globally and ended up with ifdefs. 
I agree about locally - feel free

