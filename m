Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbSI3Mpd>; Mon, 30 Sep 2002 08:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262044AbSI3Mpd>; Mon, 30 Sep 2002 08:45:33 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:56826 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262042AbSI3Mpc>; Mon, 30 Sep 2002 08:45:32 -0400
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, "David S. Miller" <davem@redhat.com>,
       mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com, kuznet@ms2.inr.ac.ru
In-Reply-To: <20020930043829.GG9920@conectiva.com.br>
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
	<20020930004559.A19071@in.ibm.com>
	<20020929.172022.23984844.davem@redhat.com>
	<20020930100317.A21939@in.ibm.com>  <20020930043829.GG9920@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:55:56 +0100
Message-Id: <1033390556.16266.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 05:38, Arnaldo Carvalho de Melo wrote:
> I'm working on Appletalk, will be fixed after X.25, humm, in fact Appletalk
> only uses SNAP on Ethernet, so it is only broken for ppptalk and ltalk, does
> anybody still uses these later two?

ppptalk is relevant to the modern world, localtalk is basically for
talking to old macintoshes many of which don't have any capability for
ethernet. I don't think either of them are even going to be performance
matters.

> Nobody working on this, as far as I know
> >         econet/af_econet.c

Ancient BBC micro protocol, could probably be done just as well in user
space. 

Alan

