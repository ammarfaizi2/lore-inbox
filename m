Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319199AbSIDPun>; Wed, 4 Sep 2002 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319201AbSIDPun>; Wed, 4 Sep 2002 11:50:43 -0400
Received: from orion.netbank.com.br.199.203.200.in-addr.arpa ([200.203.199.90]:10245
	"EHLO orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S319199AbSIDPum>; Wed, 4 Sep 2002 11:50:42 -0400
Date: Wed, 4 Sep 2002 12:55:11 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: X.25 Support in Kernel?
Message-ID: <20020904155511.GB4427@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
	linux-kernel@vger.kernel.org
References: <al4ihm$h34$1@forge.intermeta.de> <1031136982.2796.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031136982.2796.9.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 04, 2002 at 11:56:22AM +0100, Alan Cox escreveu:
> On Wed, 2002-09-04 at 10:08, Henning P. Schmiedehausen wrote:
> > Basically I need to talk to a Cisco router with X.25 protocol and be
> > able to terminate an X.25 connection in user space in an
> > application. As far as I can see, there is the easy way talking XOP
> > with the router or talking X.25 over LLC2 (which Cisco calls CMNS) for
> > which support seems to be "not yet completely functional".
> > 
> > Considering the possibility of hacking with the x.25 part of the kernel;
> > which would be the best way to start with LLC2 support? Using the driver
> > from linux-sna or hacking with net/llc ?
> 
> The base kernel llc code is junk. Thats been rewritten by the SNA folks
> and also used by the netbeui for Linux people. That should give you
> enough to talk X.25/X.29 over LLC pink book style

Alan, he is talking about net/llc, not net/802.2 8) IOW, he is talking about
the procom stuff, that is now also being used by the SNA folks.

BTW, the net/802.2 stuff already bit the dust in latest 2.5 (the code from
the toshiba-europe guy).

- Arnaldo
