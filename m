Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131807AbRCOTXn>; Thu, 15 Mar 2001 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRCOTXY>; Thu, 15 Mar 2001 14:23:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52235 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131807AbRCOTXU>; Thu, 15 Mar 2001 14:23:20 -0500
Date: Thu, 15 Mar 2001 23:35:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: J Sloan <jjs@toyota.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
In-Reply-To: <3AB1153F.802BEBA9@toyota.com>
Message-ID: <Pine.LNX.4.33.0103152334400.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, J Sloan wrote:
> Rik van Riel wrote:
> > On Thu, 15 Mar 2001, J Sloan wrote:
> >
> > >     http://lse.sourceforge.net/scheduling/
> >
> > Unrelated.   Fun, but unrelated to networking...
>
> Fun, yes, and perhaps not directly related, however
> under high load, where the sheer numbet of interrupts
> per second begins to overwhelm the kernel, might it
> not be relevant?

No.

> Or are you saying that the bottleneck is somewhere
> else completely,

Indeed. The bottleneck is with processing the incoming network
packets, at the interrupt level.

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

