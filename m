Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSLINUB>; Mon, 9 Dec 2002 08:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbSLINUB>; Mon, 9 Dec 2002 08:20:01 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:36110 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265400AbSLINUA>; Mon, 9 Dec 2002 08:20:00 -0500
Date: Mon, 9 Dec 2002 11:27:12 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in 2.5.50
Message-ID: <20021209132712.GK17067@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212091056.08860.roy@karlsbakk.net> <200212091236.06966.roy@karlsbakk.net> <Pine.LNX.4.50.0212090820250.2139-100000@montezuma.mastecende.com> <200212091423.40700.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212091423.40700.roy@karlsbakk.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 09, 2002 at 02:23:40PM +0100, Roy Sigurd Karlsbakk escreveu:
> On Monday 09 December 2002 14:21, Zwane Mwaikambo wrote:
> > On Mon, 9 Dec 2002, Roy Sigurd Karlsbakk wrote:
> > > > Is this reproducible? If so without CONFIG_PREEMPT?
> > >
> > > I found it easily reproducable - I just did the same old 'make
> > > modules_install' from the kernel dir, and BUG. Witout CONFIG_PREEMPT,
> > > however, I was not, and I tried to stress it quite a bit
> >
> > Unfortunately for you this currently falls under unsupported
> > configuration.
> 
> What's unsupported of it? And then - why do menuconfig allow me to enable both 
> TCQ and PREEMPT?

Its a development kernel... Alan keeps stating that one should not enable TCQ,
so even with this being available in make menuconfig, please try without it.

- Arnaldo
