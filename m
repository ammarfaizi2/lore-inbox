Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289364AbSAVWWL>; Tue, 22 Jan 2002 17:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289378AbSAVWVw>; Tue, 22 Jan 2002 17:21:52 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:65438 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289364AbSAVWVq> convert rfc822-to-8bit; Tue, 22 Jan 2002 17:21:46 -0500
Date: Tue, 22 Jan 2002 23:21:43 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020122220151Z289413-13996+10273@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0201222310260.13313-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> Maybe it's time for AMD/VIA/SiS/Nvidia, etc. to come up with there code for
> _ALL_ Athlon/Duron chipsets???
> As we are in trouble with AMD 4MB pages, yet.
>
> Have a look at www.vcool.de

yes ... maybee ... the problem is , that the disconnect-function  is
enabled by the chipset ... and it is a different register in every
different chipset. so it is a little bit difficult to make a solution for
all chipsets.
by the way ... i know www.vcool.de ... my work is partialy based on this.
but the vcool linux patch/version does not support kt266/kt266a chipset.
(only the kt/kx133 chipset)
after some mail exchange with the developer of vcool, i decided to wrote a
kernelpatch, which supports the kt266/kt266a chipset too. (one of my
reasosns for this was, that the developer of vcool will not develop the
linux version further) .
the second thing is, that this patch is a little bit simpler then the
(l)vcool approach ... i think ... :)

ah ... if someone sends me the the needed informations, which registers
(or register-bits) are to be changed on ther chipsets to activate the
disconnect-function, i will add this chipsets to the patch.

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

