Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRLQN03>; Mon, 17 Dec 2001 08:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRLQN0V>; Mon, 17 Dec 2001 08:26:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4227 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279313AbRLQNYt>; Mon, 17 Dec 2001 08:24:49 -0500
Date: Mon, 17 Dec 2001 08:24:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dominik Kubla <kubla@sciobyte.de>
cc: "Bradley D. LaRonde" <brad@ltc.com>, Thomas Capricelli <orzel@kde.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <20011214072540.D7457@duron.intern.kubla.de>
Message-ID: <Pine.LNX.3.95.1011217081551.19476A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, Dominik Kubla wrote:

> On Thu, Dec 13, 2001 at 01:34:45PM -0500, Richard B. Johnson wrote:
> > 
> > Well RAM is a hell of a lot cheaper than NVRAM. If you don't have
> > the required RAM on your box, the hardware engineers screwed up
> > and have to be "educated" preferably with an axe in the parking-lot.
> > 
> 
> What about security issues?  I can imagine quite a few scenarios where
> you would want to insure that you run untampered binaries. (eg. use
> ROM instead of the usual CD-ROM or read-only FD to run your security
> critical application.)
> 

I never even implied that you would run CD-ROM or FD in embedded
applications. The stuff that runs comes-from ROM, actually NVRAM so
in can be written/updated in production. However, EIP software
(Execute In Place) has always been a dog and, even Ethernet switches
3COM, Cisco, etc., don't run that way. You need to get the stuff
that runs into RAM.

Security isn't a problem with embedded systems because everything
that could possibly be done is handled with a "monitor". There is
no shell. If there is no way to execute some foreign executable,
you don't have a security issue unless some dumb alleged software
engineer added some back-doors to the monitor.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.


