Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291689AbSBXWiA>; Sun, 24 Feb 2002 17:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291693AbSBXWhu>; Sun, 24 Feb 2002 17:37:50 -0500
Received: from altus.drgw.net ([209.234.73.40]:54021 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291689AbSBXWhe>;
	Sun, 24 Feb 2002 17:37:34 -0500
Date: Sun, 24 Feb 2002 16:37:03 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224163703.G1682@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz> <20020224151923.E1682@altus.drgw.net> <20020224223759.C1814@ucw.cz> <15481.25374.253992.643727@argo.ozlabs.ibm.com> <20020224230855.A2199@ucw.cz> <15481.26582.444363.148078@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15481.26582.444363.148078@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Feb 25, 2002 at 09:23:18AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 09:23:18AM +1100, Paul Mackerras wrote:
> Vojtech Pavlik writes:
> > On Mon, Feb 25, 2002 at 09:03:10AM +1100, Paul Mackerras wrote:
> > > Vojtech Pavlik writes:
> > > 
> > > > > 83 MHz     55 MHz          41 MHz    0111 1101
> > > > 
> > > > This one is a problem, because 41*2 != 55. However, this is also illegal
> > > > according to the PCI spec.
> > > 
> > > Where does the PCI spec say that is illegal?
> > 
> > Well, I'm assuming the 41 MHz clocked bus is not a 66-MHz type PCI bus
> > (doesn't have the 66 MHz bit set and can't operate at 20.5 MHz if you
> > plug in a card that can't do 66 MHz operation), rather it's an
> > overclocked 33 MHz bus.
> 
> Yes, of course the 41MHz bus would have to conform to the rules for
> 66MHz buses.  Does it, Troy?

I believe the bridge chip (64260) is capable of 66mhz operation on both 
busses, so it would follow the 66mhz operation rules. I'm not sure about 
this since it's not an immediate problem and I don't want to wade through 
600pages of documentation to figure it out ;)

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
