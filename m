Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317343AbSGTEKu>; Sat, 20 Jul 2002 00:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSGTEKu>; Sat, 20 Jul 2002 00:10:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30984 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317343AbSGTEKt>; Sat, 20 Jul 2002 00:10:49 -0400
Date: Sat, 20 Jul 2002 01:13:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Albert Cranford <ac9410@bellsouth.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
Message-ID: <20020720041343.GC4557@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Oliver Xymoron <oxymoron@waste.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Albert Cranford <ac9410@bellsouth.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20020720010417.GA4557@conectiva.com.br> <Pine.LNX.4.44.0207192224280.1120-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207192224280.1120-100000@waste.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2002 at 10:33:50PM -0500, Oliver Xymoron escreveu:
> On Fri, 19 Jul 2002, Arnaldo Carvalho de Melo wrote:
> 
> > Em Sat, Jul 20, 2002 at 03:07:57AM +0100, Alan Cox escreveu:
> > > On Fri, 2002-07-19 at 15:06, Albert Cranford wrote:
> > > > Hello Linus,
> > > > The i2c & lm_sensors group would like to submit these 9
> > > > patches from our stable 2.6.3 package.
> > >
> > > Does this stuff still destroy thinkpads so badly they have to go back to
> > > ibm for a non warranty repair ? Nobody seems willing to provide straight
> > > answers, and I think they must be addressed before we merge such code
> >
> > Is there any other machine that is known to get fubar when using this code?
> > Perhaps a THINKPAD_SUPPORT in "Processor Types and Features", like there is
> > already for Toshiba and Dell laptops, that would disable the lm_sensors code,
> > and besides I think that this code should be marked EXPERIMENTAL, so that
> > users would be warned about these problems.

> Anything short of "Destroy my precious Thinkpad? [y/N]" probably is
> insufficient. Frankly, I don't think even that's enough. Once this is
> mainlined, someone will want to build a kitchen sink distro kernel with
> sensor support and if the code itself isn't autodetecting whether it's on
> a problematic platform, it won't be long before someone boots their
> Thinkpad off a friend's CDR and toasts it.

Oh, but that is more or less like the IDE options, if I don't read what is
there I can lose my data, specially with this dual p100 neptune I have here
with a buggy CMD640 IDE controler, running 2.5.latest-bk, rock solid! ;) And
IIRC some distros _already_ ship with lm_sensors, for the ones that don't the
current .config in the kernel srpm don't have the lm_sensors stuff selected.

But anyway, the lm_sensors team has to come with answers, if this is not
the case anymore, if some workaround was found, whatever.

People that compile the kernel should better know what he/she ask for...

- Arnaldo
