Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133024AbRDKX60>; Wed, 11 Apr 2001 19:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDKX6P>; Wed, 11 Apr 2001 19:58:15 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:31502
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S133024AbRDKX6F>; Wed, 11 Apr 2001 19:58:05 -0400
Date: Wed, 11 Apr 2001 20:06:43 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.11 of the aic7xxx driver availalbe
Message-ID: <20010411200643.A3708@animx.eu.org>
In-Reply-To: <200104100234.f3A2YFs23361@aslan.scsiguy.com> <E14mvvQ-0003zl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E14mvvQ-0003zl-00@the-village.bc.nu>; from Alan Cox on Tue, Apr 10, 2001 at 12:03:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >So, what about on an alpha system.  I've asked a few times what I could do,
> > >but you didn't help nor explain what you meant.
> > 
> > From talking to the maintainer of the QLogic driver, it appears
> > that there is a generic issue with data mapping on the Alpha.
> > The only way to correct this issue will be for someone to debug
> > it.
> 
> This seems to be the case for some Alpha boxes. On these aic7xxx dies with
> 2.4 but then so does IDE DMA for example. The real test would be to run
> Justin's 2.2.19 patch driver and see if that works on Alpha.

Ok, i tried 2.2.19 with only justin's driver.  everything works.  The tagged
queue is the default, 253, when doing:
for x in b c d;do cp zero sd$x&;done
it works.  2.2.17 stock would give me errors before the end of the write and
just hang.  2.4.x with and without justin's driver would also do the same.

I used 2.2.19 with justin's latest (as of like 3 days ago) driver.  I just
now had time to try it.

I'll give 2.4.1 another try with justin's latest driver (time permitting)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
