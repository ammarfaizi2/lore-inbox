Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267960AbRG0Rjj>; Fri, 27 Jul 2001 13:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRG0Rj3>; Fri, 27 Jul 2001 13:39:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267960AbRG0RjV>; Fri, 27 Jul 2001 13:39:21 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: vherva@mail.niksula.cs.hut.fi (Ville Herva)
Date: Fri, 27 Jul 2001 18:40:32 +0100 (BST)
Cc: kmacy@netapp.com (Kip Macy), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20010727202950.I1503@niksula.cs.hut.fi> from "Ville Herva" at Jul 27, 2001 08:29:50 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QBbE-00068M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> After fresh boot to the default RH71 kernel (2.4.2-2 or whatever it is) on
> console (no X running):
> 
> > diff -Naur /usr/src/linux.rh-default /usr/src/linux-2.4.4 > diff
> zsh: killed diff
> 
> > dmesg | tail
> kernel: out of memory, killed process n (xfs)
> kernel: out of memory, killed process n (diff)
> 
> Phew.

No argument on that one. I'm still seeing it in vanilla 2.4.6 as well but
2.4.7 is looking a lot better. 
