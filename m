Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264007AbRFNE0s>; Thu, 14 Jun 2001 00:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264012AbRFNE0i>; Thu, 14 Jun 2001 00:26:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57867 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264007AbRFNE0a>;
	Thu, 14 Jun 2001 00:26:30 -0400
Date: Thu, 14 Jun 2001 01:26:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Stephen Satchell <satch@fluent-access.com>
Cc: Daniel <ddickman@nyc.rr.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <4.3.2.7.2.20010613204443.00bbb150@mail.fluent-access.com>
Message-ID: <Pine.LNX.4.21.0106140125010.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Stephen Satchell wrote:
> At 12:24 AM 6/14/01 -0300, Rik van Riel wrote:
> >Everything you propose to get rid of are DRIVERS.  They
> >do NOT complicate the core kernel, do NOT introduce bugs
> >in the core kernel and have absolutely NOTHING to do with
> >how simple or maintainable the core kernel is.
> 
> Not quite.  There were two non-driver suggestions that the man did
> make:  remove 386/486 support and remove floating-point emulation
> support.  Both are bad for the embedded-systems space, because the 486
> is still used there widely.

Both are waaaay outside the core of the kernel, though.

> Are all the bus support code exclusively in drivers, or is there
> something compiled into the nucleus for start-up?

They're compiled into the nucleus (if you want to), but
they're in no way clogging up the source code of the core
kernel.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

