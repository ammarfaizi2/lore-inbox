Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318842AbSHLWKw>; Mon, 12 Aug 2002 18:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSHLWKw>; Mon, 12 Aug 2002 18:10:52 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:27140 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318842AbSHLWKw>; Mon, 12 Aug 2002 18:10:52 -0400
Date: Tue, 13 Aug 2002 00:13:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <20020812214032.GD20176@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0208122352440.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Aug 2002, Tom Rini wrote:

> > More examples of the cml1 limitations can be found in arch/ppc/config.in -
> > a single choice statement needs to be splitted into multiple choice
> > statements.
>
> Er, which are you referring to here?  All of the choice statements are
> done for clarity here. :)  Tho I was (and have been) pondering creating
> arch/ppc/platforms/Config-[468]xx.in, which would rather nicely move all
> of the options related to IBM 4xx processors to one file, Motorola 8xx
> to another, and general PPC's nicely.

There is still a bit of overlap. Roughly it's possible to sort the machine
types by cpu type, but IMO it's not the best solution. I think it would be
better to sort them by general machine type.

bye, Roman

