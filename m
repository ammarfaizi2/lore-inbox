Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRIJNwc>; Mon, 10 Sep 2001 09:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269515AbRIJNwX>; Mon, 10 Sep 2001 09:52:23 -0400
Received: from spike.porcupine.org ([168.100.189.2]:60431 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S269413AbRIJNwK>; Mon, 10 Sep 2001 09:52:10 -0400
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010910145325.X26627@khan.acc.umu.se> "from David Weinehall at
 Sep 10, 2001 02:53:25 pm"
To: David Weinehall <tao@acc.umu.se>
Date: Mon, 10 Sep 2001 09:52:30 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010910135230.EA1BFBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall:
> On Mon, Sep 10, 2001 at 08:26:03AM -0400, Wietse Venema wrote:
> > David Weinehall:
> > > Are you saying that Linux should implement compability with _new_
> > > features in FreeBSD 4.x, while at the same time frowning at the fact
> > > that Linux introduces a new API?! The mind boggles at the thought.
> > 
> > SIOCGIFNETMASK is not "new". It exists in systems as ancient as
> > SunOS 4.x, which pre dates FreeBSD 4.x by about 10 years. 
> > 
> > Evidence: RTFM the Postfix source code :-)
> > 
> > In other words, SIOCGIFNETMASK existed long before Linux could plug
> > into a network.

Other vendors with SIOCGIFNETMASK in 10-year old releases: DEC, HP, IBM.

> "[snip] old and the new stuff, please name precisely the objections
> against portability and compatibility with FreeBSD 4.x aliasing."
>                                            ^^^^^^^^^^^^^^^^^^^^
> This is what lead me to my conclusion. Care to clarify? If you simply
> meant SIOCGIFNETMASK, why not write that instead instead of involving
> FreeBSD 4.x?!

The poster was referring to systems that he has personal experience
with.  Not everyone is a dinosaur like I am.

	Wietse
