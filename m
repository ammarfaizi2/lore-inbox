Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbRGNUDg>; Sat, 14 Jul 2001 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbRGNUD0>; Sat, 14 Jul 2001 16:03:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264856AbRGNUDI>; Sat, 14 Jul 2001 16:03:08 -0400
Subject: Re: Again: Linux 2.4.x and AMD Athlon
To: gfriedmann@mediaone.net (Gabriel Friedmann)
Date: Sat, 14 Jul 2001 21:04:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107141954.f6EJsUS09999@demai05.mw.mediaone.net> from "Gabriel Friedmann" at Jul 14, 2001 03:54:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LVe3-0001fO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This bums me out.  AS i am using ABIT kt7a-raid with the kt133a chipset, and 
> 3dnow kernel optimizations and i oops right as i boot (sometimes before i 
> complete any init-scripts).

Yep. Its not an ideal situation. People are btw also reporting similar
photoshop oopses in windows. I suspect related problems 

> Anyways...  I am confirming a problem with my via chipset and 3dnow 
> optimizations.  VIA82CXXX in kernel support not affecting outcome.

Nope - you want the via82cxxx ide support, that is a big performance win as
you get UDMA IDE. The prefetch/movntq optimisations are less of an impact,
so an Athlon with a non athlon optimised kernel is still a killer devel box

