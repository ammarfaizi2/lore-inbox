Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269209AbTCBNkp>; Sun, 2 Mar 2003 08:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269211AbTCBNkp>; Sun, 2 Mar 2003 08:40:45 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:31754 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269209AbTCBNko>; Sun, 2 Mar 2003 08:40:44 -0500
Subject: Re: [PATCH] kernel source spellchecker
From: Steven Cole <elenstev@mesatop.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dan Kegel <dank@kegel.com>, Matthias Schniedermeyer <ms@citd.de>,
       Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
In-Reply-To: <1046604117.12947.16.camel@imladris.demon.co.uk>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>
	<3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com>
	<1046578585.2544.451.camel@spc1.mesatop.com> 
	<1046604117.12947.16.camel@imladris.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 02 Mar 2003 06:49:50 -0700
Message-Id: <1046612993.7527.472.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 04:21, David Woodhouse wrote:
> On Sun, 2003-03-02 at 04:16, Steven Cole wrote:
> 
> > Another correction to the corrections file:
> > 
> > Licensed=Licenced
> >          ^^^^^^^^
> > I think Licenced is OK in the UK.
> > See http://www.gsu.edu/~wwwesl/egw/jones/differences.htm
> 
> 'Licenced' is not OK in the UK; it should be corrected to 'Licensed'.
> 
> In the UK, 'licence' is a noun, 'license' is a verb -- just as with
> practice/practise and advice/advise etc. in both variants of the
> language.

Thanks for the explanation.

> 
> I think we also want to add:
> 
> Decompressing=Uncompressing
> 
> You should also refrain from 'correcting' the already-correct British
> spellings of 'modelled'.
> 
> It might also be worth adding a list of 'suspect' spellings -- which
> require human intervention. Such items might include 'indices=indexes'
> and 'erratum=errata' although you can't do it automatically because
> sometimes the right-hand side is actually correct.

In my first pass through the tree, it looks like there are quite a few
_correct_ uses of errata, but there indeed some of these:

./drivers/net/tulip/de2104x.c:  /* Avoid a chip errata by prefixing a dummy entry. */

I think the errata/erratum issue requires careful editing.

Steven




