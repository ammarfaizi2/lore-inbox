Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSANU4W>; Mon, 14 Jan 2002 15:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSANU4O>; Mon, 14 Jan 2002 15:56:14 -0500
Received: from quark.didntduck.org ([216.43.55.190]:20490 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S289048AbSANUz6>; Mon, 14 Jan 2002 15:55:58 -0500
Message-ID: <3C4345C8.92F85166@didntduck.org>
Date: Mon, 14 Jan 2002 15:55:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Charles Cazabon <linux@discworld.dyndns.org>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the 
 elegant solution)
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114142605.A4702@twoflower.internal.do> <20020114151942.A20309@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Charles Cazabon <linux@discworld.dyndns.org>:
> > > "Crap." Melvin thinks.  "I don't remember what kind of network card I
> > > compiled in.  Am I going to have to open this puppy up just to eyeball
> > > the hardware?"
> >
> > Uh, no.  Try `lsmod`.
> 
> He hard-compiled in that driver.  lsmod(1) can't see it.

cat /proc/ioports.  If the card is in use, it will show up there.

--

				Brian Gerst
