Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSHWPQ6>; Fri, 23 Aug 2002 11:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSHWPQ6>; Fri, 23 Aug 2002 11:16:58 -0400
Received: from mail.iok.net ([62.249.129.22]:46862 "EHLO mars.iok.net")
	by vger.kernel.org with ESMTP id <S318868AbSHWPQ6>;
	Fri, 23 Aug 2002 11:16:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Holger Schurig <h.schurig@mn-logistik.de>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: cell-phone like keyboard driver anywhere?
Date: Fri, 23 Aug 2002 17:10:19 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200208210932.36132.h.schurig@mn-logistik.de> <200208230954.11132.h.schurig@mn-logistik.de> <20020823142140.GA27454@ravel.coda.cs.cmu.edu>
In-Reply-To: <20020823142140.GA27454@ravel.coda.cs.cmu.edu>
X-Archive: encrypt
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208231710.19950.h.schurig@mn-logistik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Press 5 (JKL), all songs starting with either j, k, or l will be
> selected, and the display shows 'Kind of Magic'. Press 3 (DEF) and it
> limits the selection to any songs that have one of those letters in the

That sounds pretty much like high application stuff. If I had that in my mind, 
I would not have had asked in linux-KERNEL. For an application it's easy to 
have some directory.

The solution you're proposing is good and elegant --- in it's domain. It 
solves one narrow problem. I need a solution that is broader. Your solution 
wouldn't work with Qt/Embedded apps AND X11 apps AND ncurses apps. Maybe 
because your hardware is only used for playing mpegs. But what if the 
computer is used for tn-5250 (ncurses), Konq/Embedded (Qt/Embedded) and Java 
(X11), just as the user pleases?  In this case you need something general, 
and that usually means a kernel driver (because, in our case, there is no 
kernel interface for a user-space program that can inject key codes back into 
the kernel so that the keycodes would be subject of normal 
controlling-tty-handling).

