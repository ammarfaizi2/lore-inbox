Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRI1WZx>; Fri, 28 Sep 2001 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276324AbRI1WZo>; Fri, 28 Sep 2001 18:25:44 -0400
Received: from pc-62-30-107-95-az.blueyonder.co.uk ([62.30.107.95]:28654 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S276330AbRI1WZ1>; Fri, 28 Sep 2001 18:25:27 -0400
Date: Fri, 28 Sep 2001 23:24:58 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: CPU frequency shifting "problems"
Message-ID: <20010928232458.A15016@kushida.degree2.com>
In-Reply-To: <Pine.LNX.4.33.0109280902250.1682-100000@penguin.transmeta.com> <m11ykr5a9y.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m11ykr5a9y.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Sep 28, 2001 at 02:29:45PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > What does exist is the bus clock (well, a multiple of it, but you get the
> > idea), and that one is stable. I bet PCI devices don't like to be randomly
> > driven at frequencies "somewhere between 12 and 33MHz" depending on load ;)
> 
> I doubt they would like it but it is perfectly legal (PCI spec..) to
> vary the pci clock, depending upon load.   

Yes it is.  Also, the PCI clock is frequency modulated to reduce
electrical interference.  (Or on a more cynical note, to pass the
official emissions tests ;-)

However it's common practice to PLL to the PCI clock, for clock
distribution on a board, so varying the frequency must be done in a
strictly constrained fashion.

-- Jamie
