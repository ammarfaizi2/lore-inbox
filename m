Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTWa4>; Tue, 20 Feb 2001 17:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129176AbRBTWar>; Tue, 20 Feb 2001 17:30:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47366 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129107AbRBTWai>; Tue, 20 Feb 2001 17:30:38 -0500
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 20 Feb 2001 22:33:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.21.0102201827520.3901-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Feb 20, 2001 06:30:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VLLS-0000rO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  extern void __wait_on_buffer(struct buffer_head *);
> > > +extern void __lock_buffer(struct buffer_head *);
> > 
> > So are we starting 2.5 now ?
> 
> Alan,
> 
> This patch only avoids unecessary wakeups. It doesn't add any new
> functionality.

I think making potentially very hard to debug changes to core code for
minor performance reasons alone isnt 2.4.x work. At least not yet

