Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSESAS3>; Sat, 18 May 2002 20:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314075AbSESAS2>; Sat, 18 May 2002 20:18:28 -0400
Received: from panda.sul.com.br ([200.219.150.4]:28944 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314069AbSESAS2>;
	Sat, 18 May 2002 20:18:28 -0400
Date: Sat, 18 May 2002 15:18:21 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: casdcsdc sdfccsdcsd <computrius@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: davicom 9102 and linux 2.5
Message-ID: <20020518181821.GA3683@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	casdcsdc sdfccsdcsd <computrius@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020518235854.33076.qmail@web13905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 18, 2002 at 04:58:54PM -0700, casdcsdc sdfccsdcsd escreveu:
> I just tryed to comile and install the 2.5 linux kernel, and I noticed
> something that compleatly stumped me, as well as pissed me off. YOU TOOK OUT
> THE DRIVER FOR DAVICOM 9102 NETWORK CARD! WHY?!? it doesnt make any sense,
> when you make a new version, you ADD FEATURES, YOU DONT TAKE THEM OUT!

Calm down casdcsdc! :) Look at the docs (and grep the sources ;) )... it seems
it is now supported by the tulip driver, see:

drivers/net/tulip/ChangeLog
drivers/net/tulip/dmfe.c

>From Documentation/networking/dmfe.txt

        A Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver for Linux.

Suggestion to tulip maintainer: if this is the case, make a note in
Documentation/networking/dmfe.txt, that is still in the kernel, but beware,
the 2.5 tree I'm using is not the latest...

- Arnaldo
