Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRABSiW>; Tue, 2 Jan 2001 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRABSiN>; Tue, 2 Jan 2001 13:38:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13075 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129348AbRABSh4>; Tue, 2 Jan 2001 13:37:56 -0500
Subject: Re: [PATCH] Re: 2.4.0-testX fails to compile on my Athlon
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Tue, 2 Jan 2001 18:02:29 +0000 (GMT)
Cc: tleete@mountain.net, linux-kernel@vger.kernel.org
In-Reply-To: <11718F7840A2@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Jan 02, 2001 06:44:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DVlW-0002cO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For 2.4.0, probably disabling 3DNow in kernel when using SMP is best 
> solution, as AFAIK nobody tested correctness of 3DNow code on SMP... Or is
> it obviously correct?

Its obviously correct.  At least if it doesnt work the MMX/XMM code for
raid should also fail horribly ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
