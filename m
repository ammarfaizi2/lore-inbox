Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272012AbRIJIGQ>; Mon, 10 Sep 2001 04:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273218AbRIJIGH>; Mon, 10 Sep 2001 04:06:07 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:63116 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S272012AbRIJIFu>;
	Mon, 10 Sep 2001 04:05:50 -0400
Date: Mon, 10 Sep 2001 10:05:37 +0200
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wietse Venema <wietse@porcupine.org>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010910100537.W26627@khan.acc.umu.se>
In-Reply-To: <20010906181826.9CCECBC06C@spike.porcupine.org> <E15f55T-0000Kc-00@the-village.bc.nu> <20010906221359.G13547@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010906221359.G13547@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Sep 06, 2001 at 10:13:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 10:13:59PM +0200, Matthias Andree wrote:
> On Thu, 06 Sep 2001, Alan Cox wrote:
> 
> > I think you have the metaphor wrong. The older API is a bit like the 
> > cavalry charging into battle at the start of world war one. It may have been
> > how everyone did it but they guys with the "newfangled, really not how it
> > should be done, definitely not cricket"  machine guns got the last laugh
> 
> Alan, portability is an issue or Linux will lose. Admittedly, legacy
> interfaces do not support all of those new features, but a rather
> trivial patch of mine brings SIOCGIFNETMASK compatibility with both the
> old and the new stuff, please name precisely the objections against
> portability and compatibility with FreeBSD 4.x aliasing.

Are you saying that Linux should implement compability with _new_
features in FreeBSD 4.x, while at the same time frowning at the fact
that Linux introduces a new API?! The mind boggles at the thought.

Please accept, that sometimes, just sometimes, there is a superior way
to do something, and implementing support for that might not be such
a bad idea after all. Whining about this causing "bloat and maintainance
nightmares" (no, not a direct quote, sorry for that) doesn't cut it,
because there are probably more Linux-machines running the software than
any BSD-machines, thus the netlink-code will get _more_ testing than
the legacy API.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
