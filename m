Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290082AbSAWUzb>; Wed, 23 Jan 2002 15:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290080AbSAWUzT>; Wed, 23 Jan 2002 15:55:19 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:19935 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290079AbSAWUzO> convert rfc822-to-8bit; Wed, 23 Jan 2002 15:55:14 -0500
Date: Wed, 23 Jan 2002 21:55:11 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Timothy Covell <timothy.covell@ashavan.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <200201232023.VAA07669@rzmail.uni-trier.de>
Message-ID: <Pine.LNX.4.40.0201232150160.2478-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> > eenabling the discconect function causes a performance drop of about 2-3 %
> > as far as i heared ...
>
> If not smaller. Read the VCool doku.

i know this doku :)

>
> > but this patch is only for athlon
>
> Athlon and Duron
>

ant athlon xp :) ... ok .. .i generalized it  ....

> > processors on an board with via chipset ...
>
> AMD 750/760/maybe MP/MPX, SiS, Ali, Nvidia (?), etc.
>

my patch only supports the kt133/kx133 and kt266/kt266a chipset by now ...
maybe it supports the k133a chipset (not tested ... if it has the same
register layout as the kt133 it will work). i have some informations on
the sis735 ... but as far as i know the k7s5a (most common mobo woth
sis735) has some serios problems with the disconnect on STPGNT detect
function ... maybe i will add the sis735 to the patch but it will be a
littlebit risky i think :)
if i get additional informations on the other chipsets, i will add them to

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

