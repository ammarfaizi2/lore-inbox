Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291664AbSBXW1f>; Sun, 24 Feb 2002 17:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291637AbSBXW1Q>; Sun, 24 Feb 2002 17:27:16 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:50439 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291633AbSBXW04>;
	Sun, 24 Feb 2002 17:26:56 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15481.26582.444363.148078@argo.ozlabs.ibm.com>
Date: Mon, 25 Feb 2002 09:23:18 +1100 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <20020224230855.A2199@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org>
	<Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
	<20020224013038.G10251@altus.drgw.net>
	<3C78DA19.4020401@evision-ventures.com>
	<20020224142902.C1682@altus.drgw.net>
	<20020224215422.B1706@ucw.cz>
	<20020224151923.E1682@altus.drgw.net>
	<20020224223759.C1814@ucw.cz>
	<15481.25374.253992.643727@argo.ozlabs.ibm.com>
	<20020224230855.A2199@ucw.cz>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:
> On Mon, Feb 25, 2002 at 09:03:10AM +1100, Paul Mackerras wrote:
> > Vojtech Pavlik writes:
> > 
> > > > 83 MHz     55 MHz          41 MHz    0111 1101
> > > 
> > > This one is a problem, because 41*2 != 55. However, this is also illegal
> > > according to the PCI spec.
> > 
> > Where does the PCI spec say that is illegal?
> 
> Well, I'm assuming the 41 MHz clocked bus is not a 66-MHz type PCI bus
> (doesn't have the 66 MHz bit set and can't operate at 20.5 MHz if you
> plug in a card that can't do 66 MHz operation), rather it's an
> overclocked 33 MHz bus.

Yes, of course the 41MHz bus would have to conform to the rules for
66MHz buses.  Does it, Troy?

Paul.
