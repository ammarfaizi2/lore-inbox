Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSGTDbG>; Fri, 19 Jul 2002 23:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317339AbSGTDbG>; Fri, 19 Jul 2002 23:31:06 -0400
Received: from waste.org ([209.173.204.2]:64734 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317338AbSGTDbG>;
	Fri, 19 Jul 2002 23:31:06 -0400
Date: Fri, 19 Jul 2002 22:33:50 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Albert Cranford <ac9410@bellsouth.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
In-Reply-To: <20020720010417.GA4557@conectiva.com.br>
Message-ID: <Pine.LNX.4.44.0207192224280.1120-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Arnaldo Carvalho de Melo wrote:

> Em Sat, Jul 20, 2002 at 03:07:57AM +0100, Alan Cox escreveu:
> > On Fri, 2002-07-19 at 15:06, Albert Cranford wrote:
> > > Hello Linus,
> > > The i2c & lm_sensors group would like to submit these 9
> > > patches from our stable 2.6.3 package.
> >
> > Does this stuff still destroy thinkpads so badly they have to go back to
> > ibm for a non warranty repair ? Nobody seems willing to provide straight
> > answers, and I think they must be addressed before we merge such code
>
> Is there any other machine that is known to get fubar when using this code?
> Perhaps a THINKPAD_SUPPORT in "Processor Types and Features", like there is
> already for Toshiba and Dell laptops, that would disable the lm_sensors code,
> and besides I think that this code should be marked EXPERIMENTAL, so that
> users would be warned about these problems.

Anything short of "Destroy my precious Thinkpad? [y/N]" probably is
insufficient. Frankly, I don't think even that's enough. Once this is
mainlined, someone will want to build a kitchen sink distro kernel with
sensor support and if the code itself isn't autodetecting whether it's on
a problematic platform, it won't be long before someone boots their
Thinkpad off a friend's CDR and toasts it.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

