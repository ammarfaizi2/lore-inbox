Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318746AbSHBH2V>; Fri, 2 Aug 2002 03:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSHBH2V>; Fri, 2 Aug 2002 03:28:21 -0400
Received: from denise.shiny.it ([194.20.232.1]:17866 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S318746AbSHBH2V>;
	Fri, 2 Aug 2002 03:28:21 -0400
Message-ID: <XFMail.20020802093146.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0208020009490.28515-100000@serv>
Date: Fri, 02 Aug 2002 09:31:46 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: manipulating sigmask from filesystems and drivers
Cc: linux-kernel@vger.kernel.org, alan@redhat.com,
       David Howells <dhowells@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Stop arguing about this. It's a FACT.
>
> Linus, it's not that I don't want to believe you, but e.g. the SUS doesn't
> make that special exception.
> Installing signal handlers and not expecting EINTR _is_ sloppy
> programming.

Linus is right. It's impossible to change default rw semantics
without breaking things. Anyway, we can add another non-standard
file flag (that's likely to remain mostly unused).


Bye.

