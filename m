Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSGTBB0>; Fri, 19 Jul 2002 21:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSGTBB0>; Fri, 19 Jul 2002 21:01:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21011 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317278AbSGTBBZ>; Fri, 19 Jul 2002 21:01:25 -0400
Date: Fri, 19 Jul 2002 22:04:17 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Cranford <ac9410@bellsouth.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
Message-ID: <20020720010417.GA4557@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Albert Cranford <ac9410@bellsouth.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3D381CD1.6A0B9909@bellsouth.net> <1027130877.14314.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027130877.14314.6.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 20, 2002 at 03:07:57AM +0100, Alan Cox escreveu:
> On Fri, 2002-07-19 at 15:06, Albert Cranford wrote:
> > Hello Linus,
> > The i2c & lm_sensors group would like to submit these 9
> > patches from our stable 2.6.3 package.
> 
> Does this stuff still destroy thinkpads so badly they have to go back to
> ibm for a non warranty repair ? Nobody seems willing to provide straight
> answers, and I think they must be addressed before we merge such code

Is there any other machine that is known to get fubar when using this code?
Perhaps a THINKPAD_SUPPORT in "Processor Types and Features", like there is
already for Toshiba and Dell laptops, that would disable the lm_sensors code,
and besides I think that this code should be marked EXPERIMENTAL, so that
users would be warned about these problems.

Lots of people already use it and it'd be nice to have it in mainline, with
these big fat warnings.

- Arnaldo
