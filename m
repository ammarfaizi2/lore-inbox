Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSFKWzG>; Tue, 11 Jun 2002 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSFKWzG>; Tue, 11 Jun 2002 18:55:06 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:518 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316960AbSFKWzF>; Tue, 11 Jun 2002 18:55:05 -0400
Date: Tue, 11 Jun 2002 18:49:40 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <002101c2115d$1c0bc7c0$baefb0d4@nick>
Message-ID: <Pine.LNX.3.96.1020611184236.29598B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Nick Evgeniev wrote:

> I don't want to make experiments in production environment anymore...
> And it's unfair to the rest of Linux users to keep broken drivers in
> stable kernel...  Because nobody expects that stable kernel will rip
> your fs _daily_. 

  I remember when SMP started, if used with certain filesystem types it
would regularly eat the f/s data. The argument was made that it should be
commented out of the config file, so you really had to work at getting it
turned on. In spite of that a number of (from memory early 2.2) kernels
had the defect and led to people thinking that Linux was unreliable in
general.

  I agree that if it has known problems which destroy data it should be
unavailable in the stable kernel. It certainly sounds as if that's the
case, and the driver could be held out until 2.4.20 or so when it can be
fixed, or if it can't be fixed it can just go away.

  A stable kernel release should be, well... stable. Give the enemies of
Linux no ammunition, they make up enough crap as it is.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

