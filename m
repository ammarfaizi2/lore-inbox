Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291539AbSBXWKC>; Sun, 24 Feb 2002 17:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSBXWJy>; Sun, 24 Feb 2002 17:09:54 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9989 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S291539AbSBXWJj>;
	Sun, 24 Feb 2002 17:09:39 -0500
Date: Sun, 24 Feb 2002 23:08:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Mackerras <paulus@samba.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224230855.A2199@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz> <20020224151923.E1682@altus.drgw.net> <20020224223759.C1814@ucw.cz> <15481.25374.253992.643727@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15481.25374.253992.643727@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Feb 25, 2002 at 09:03:10AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 09:03:10AM +1100, Paul Mackerras wrote:
> Vojtech Pavlik writes:
> 
> > > 83 MHz     55 MHz          41 MHz    0111 1101
> > 
> > This one is a problem, because 41*2 != 55. However, this is also illegal
> > according to the PCI spec.
> 
> Where does the PCI spec say that is illegal?

Well, I'm assuming the 41 MHz clocked bus is not a 66-MHz type PCI bus
(doesn't have the 66 MHz bit set and can't operate at 20.5 MHz if you
plug in a card that can't do 66 MHz operation), rather it's an
overclocked 33 MHz bus.

And running PCI over 33 MHz isn't legal in the PCI spec as far as I
know. You can go lower, but I think the limit is 16 MHz there.

-- 
Vojtech Pavlik
SuSE Labs
