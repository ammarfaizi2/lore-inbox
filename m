Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLDBF1>; Sun, 3 Dec 2000 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLDBFR>; Sun, 3 Dec 2000 20:05:17 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:62736 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129248AbQLDBFJ>; Sun, 3 Dec 2000 20:05:09 -0500
Date: Mon, 4 Dec 2000 01:34:40 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_ftp and different ports
In-Reply-To: <Pine.LNX.4.21.0012032259320.14309-100000@tux.rsn.hk-r.se>
Message-ID: <Pine.LNX.4.21.0012040125430.14854-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Martin Josefsson wrote:

> On Sun, 3 Dec 2000, Taco IJsselmuiden wrote:
> 
> > Hi,
> > 
> > I'm having trouble masquerading ftp-ports other than 20/21.
> > For some service i'm using, i need to masquerade port 42,43,62,63 for FTP
> > (I know it's weird...).
> > Now, when using 2.2.x kernels i could use
> > 'insmod ip_masq_ftp ports=21,41,42,62,63'
> > but using 2.4.0-testx the 'ports=' parameter doesn't seem to work for
> > ip_nat_ftp.
> > Is there any other param I should use (couldn't find it in the docs ;(( )
> 
> There is a ftp-multi patch that you can apply to get this working
> 
> download iptables-1.2 and run 'make patch-o-matic' and apply the ftp-multi
> patch and recompile the ftp module... you're done.
hmm... iptables-1.2 ?
I can only find iptables-1.1.2 (netfilter.filewatcher.org,
netfilter.kernelnotes.org)...
Where could I find 1.2 then ??

I'm running 1.1.2 right now, actually, which should have the 'ftp-multi
patch for non-standard ftp servers'...

Greetz,
Taco.
---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
