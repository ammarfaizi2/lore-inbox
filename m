Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSBDWPf>; Mon, 4 Feb 2002 17:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSBDWP1>; Mon, 4 Feb 2002 17:15:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17668 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289210AbSBDWPR>; Mon, 4 Feb 2002 17:15:17 -0500
Date: Mon, 4 Feb 2002 17:13:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <3C5AF6B5.5080105@zytor.com>
Message-ID: <Pine.LNX.3.96.1020204171035.31056A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, H. Peter Anvin wrote:

> Andreas Dilger wrote:
> 
> > 
> > Maybe, i8XX hardware RNG should feed the /dev/random entropy pool
> > directly if you enable the chipset support (with an option to turn
> > it off if you want to use the user-space tools or a separate RNG),
> > so that people get the benefits of the h/w RNG without having to
> > install another tool (which they won't know about)?
> 
> "Let's put it in the kernel because people are too stupid to install it
> otherwise"?
> 
> No thank you.

Why would the kernel NOT use available source of entropy? If the kernel is
gathering entropy, in what way is user mode better? Are you going to make
users install disk, keystroke, packet, etc daemons to do the work of the
kernel?

The only reason I can see for not doing this is if there is reason to
believe that it is not producing useful information.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

