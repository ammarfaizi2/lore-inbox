Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRIJMyv>; Mon, 10 Sep 2001 08:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRIJMyc>; Mon, 10 Sep 2001 08:54:32 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:34980 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S270825AbRIJMyN>;
	Mon, 10 Sep 2001 08:54:13 -0400
Date: Mon, 10 Sep 2001 14:53:25 +0200
From: David Weinehall <tao@acc.umu.se>
To: Wietse Venema <wietse@porcupine.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010910145325.X26627@khan.acc.umu.se>
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> <20010910122603.80CA4BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010910122603.80CA4BC06C@spike.porcupine.org>; from wietse@porcupine.org on Mon, Sep 10, 2001 at 08:26:03AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 08:26:03AM -0400, Wietse Venema wrote:
> David Weinehall:
> > Are you saying that Linux should implement compability with _new_
> > features in FreeBSD 4.x, while at the same time frowning at the fact
> > that Linux introduces a new API?! The mind boggles at the thought.
> 
> SIOCGIFNETMASK is not "new". It exists in systems as ancient as
> SunOS 4.x, which pre dates FreeBSD 4.x by about 10 years. 
> 
> Evidence: RTFM the Postfix source code :-)
> 
> In other words, SIOCGIFNETMASK existed long before Linux could plug
> into a network.

"[snip] old and the new stuff, please name precisely the objections
against portability and compatibility with FreeBSD 4.x aliasing."
                                           ^^^^^^^^^^^^^^^^^^^^
This is what lead me to my conclusion. Care to clarify? If you simply
meant SIOCGIFNETMASK, why not write that instead instead of involving
FreeBSD 4.x?!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
