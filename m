Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQLDCdd>; Sun, 3 Dec 2000 21:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLDCdX>; Sun, 3 Dec 2000 21:33:23 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:3968 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S129324AbQLDCdK>;
	Sun, 3 Dec 2000 21:33:10 -0500
Date: Mon, 4 Dec 2000 03:00:40 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Taco IJsselmuiden <taco@wep.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_ftp and different ports
In-Reply-To: <Pine.LNX.4.21.0012040125430.14854-100000@hewpac.taco.dhs.org>
Message-ID: <Pine.LNX.4.21.0012040258260.479-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Taco IJsselmuiden wrote:

> On Sun, 3 Dec 2000, Martin Josefsson wrote:
> 
> > On Sun, 3 Dec 2000, Taco IJsselmuiden wrote:
> > 
> > > Hi,
> > > 
> > > I'm having trouble masquerading ftp-ports other than 20/21.
> > > For some service i'm using, i need to masquerade port 42,43,62,63 for FTP
> > > (I know it's weird...).
> > > Now, when using 2.2.x kernels i could use
> > > 'insmod ip_masq_ftp ports=21,41,42,62,63'
> > > but using 2.4.0-testx the 'ports=' parameter doesn't seem to work for
> > > ip_nat_ftp.
> > > Is there any other param I should use (couldn't find it in the docs ;(( )
> > 
> > There is a ftp-multi patch that you can apply to get this working
> > 
> > download iptables-1.2 and run 'make patch-o-matic' and apply the ftp-multi
> > patch and recompile the ftp module... you're done.
> hmm... iptables-1.2 ?
> I can only find iptables-1.1.2 (netfilter.filewatcher.org,
> netfilter.kernelnotes.org)...
> Where could I find 1.2 then ??

Ouch, I was typing a little too fast there... it should be 1.1.2

> I'm running 1.1.2 right now, actually, which should have the 'ftp-multi
> patch for non-standard ftp servers'...

Well have you applied the ftp-multi patch? (this is a patch so that the
ftp-module takes a ports parameter, the thing you probably are talking
about is a bug which I and several others found in the ftp-module, these
two things have nothing with each other to do.) 

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
