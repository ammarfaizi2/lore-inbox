Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSGLSwH>; Fri, 12 Jul 2002 14:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSGLSwG>; Fri, 12 Jul 2002 14:52:06 -0400
Received: from tao-eth.natur.cuni.cz ([195.113.46.57]:26892 "EHLO
	natur.cuni.cz") by vger.kernel.org with ESMTP id <S316792AbSGLSwD>;
	Fri, 12 Jul 2002 14:52:03 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Fri, 12 Jul 2002 20:54:46 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Tom Rini <trini@kernel.crashing.org>
cc: Thunder from the hill <thunder@ngforever.de>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Missing files in 2.4.19-rc1
In-Reply-To: <20020712185023.GL695@opus.bloom.county>
Message-ID: <Pine.OSF.4.44.0207122052150.281934-100000@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Tom Rini wrote:

> On Fri, Jul 12, 2002 at 08:39:18PM +0200, Martin MOKREJ? wrote:
>
> > `make dep` gave again:
> [snip]
> > au1000_gpio.c:41: asm/au1000.h: No such file or directory
> > au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
>
> These aren't an issue, since you're not compiling for MIPS, and that's
> for the MIPS-specific au1000 GPIO driver.  And those files aren't
> missing on MIPS.

Hmm, I just tried with plain 2.4.18 extracted and have the same problem.
Should I just ignore `make dep` errors and just compile? Probably yes,
as I'm running 2.4.10-pre2 for some months now with no real troubles
anyway.

But the source tree is broken, right? ;-)
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585

