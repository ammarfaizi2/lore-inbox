Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRCVOsa>; Thu, 22 Mar 2001 09:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRCVOsU>; Thu, 22 Mar 2001 09:48:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5383 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132039AbRCVOsG>; Thu, 22 Mar 2001 09:48:06 -0500
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 22 Mar 2001 14:49:05 +0000 (GMT)
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <3ABA00BB.A9C2DF1B@mandrakesoft.com> from "Jeff Garzik" at Mar 22, 2001 08:40:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14g6Oj-0002eA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hmm, on second thought, I think I would prefer the attached patch
> (compiled but not tested).

Pointless...

> Hardware usually returns all 1's when it's not present, or not working,
> so think checking for addresses filled with 1's is a good idea too.

If the multicast bit is set then we already fail the address. Your test
does nothing.

Alan

