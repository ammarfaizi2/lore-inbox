Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSKBUF3>; Sat, 2 Nov 2002 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbSKBUF3>; Sat, 2 Nov 2002 15:05:29 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64906 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261379AbSKBUF2>; Sat, 2 Nov 2002 15:05:28 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <20021102185508.GF27926@conectiva.com.br>
References: <1036157313.12693.15.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com> 
	<20021102185508.GF27926@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 20:31:29 +0000
Message-Id: <1036269089.16820.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 18:55, Arnaldo Carvalho de Melo wrote:
> SPX was also removed (hey, it never worked anyway) and probably econet and
> ATM will be removed as well if nobody jumps to fix it (I mean net/atm, not
> drivers/atm, but I'm not sure the later will be useful without the former).

ATM is actively used by large numbers of people [1]. Its in the fix
rather than remove category. Econet should be trivial and might as well
just be marked CONFIG_OBSOLETE until someone does deal with it.

Alan
[1] PPPoATM is used for a large number of DSL connections

