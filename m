Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSKBUFq>; Sat, 2 Nov 2002 15:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261382AbSKBUFq>; Sat, 2 Nov 2002 15:05:46 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:48138 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261381AbSKBUFo>; Sat, 2 Nov 2002 15:05:44 -0500
Date: Sat, 2 Nov 2002 17:12:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021102201208.GK27926@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bill Davidsen <davidsen@tmr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
References: <1036157313.12693.15.camel@irongate.swansea.linux.org.uk> <Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com> <20021102185508.GF27926@conectiva.com.br> <1036269089.16820.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036269089.16820.23.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 02, 2002 at 08:31:29PM +0000, Alan Cox escreveu:
> On Sat, 2002-11-02 at 18:55, Arnaldo Carvalho de Melo wrote:
> > SPX was also removed (hey, it never worked anyway) and probably econet and
> > ATM will be removed as well if nobody jumps to fix it (I mean net/atm, not
> > drivers/atm, but I'm not sure the later will be useful without the former).
 
> ATM is actively used by large numbers of people [1]. Its in the fix
> rather than remove category. Econet should be trivial and might as well
> just be marked CONFIG_OBSOLETE until someone does deal with it.

Oh, cool, way more motivation to fix that stuff 8)
