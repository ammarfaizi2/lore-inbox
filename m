Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSGJNuz>; Wed, 10 Jul 2002 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGJNuy>; Wed, 10 Jul 2002 09:50:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22028 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315265AbSGJNuw>; Wed, 10 Jul 2002 09:50:52 -0400
Subject: Re: BKL removal
To: jlnance@intrex.net
Date: Wed, 10 Jul 2002 15:17:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020710093101.C1446@tricia.dyndns.org> from "jlnance@intrex.net" at Jul 10, 2002 09:31:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SIHK-00078r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 09, 2002 at 11:21:25PM +0100, Alan Cox wrote:
> > 
> > There are lots of them hiding 8)
> 
> Just out of curisoty.  If I remember correctly SMP came to Linux when
> Caldera hired you to make it work.  Did you invent the BKL?

Caldera bought the hardware, rather than hiring me. Having said that at
the time the dual P90 board + processors was not exactly cheap. The board
btw is alive and well and currently owned by Dave Jones.

As far as the locking goes I invented the big kernel lock, but the basis of
that is all taken directly from "Unix systems for modern architectures"
by Schimmel which is required reading for anyone who cares about caches,
SMP and locking. 

	I'd prefer the trees to be separate for testing purposes: it 
	doens't	make much sense to have SMP support as a normal kernel 
	feature when most people won't have SMP anyway"
			-- Linus Torvalds

Alan
