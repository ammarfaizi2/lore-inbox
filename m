Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSKRBrj>; Sun, 17 Nov 2002 20:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSKRBrj>; Sun, 17 Nov 2002 20:47:39 -0500
Received: from almesberger.net ([63.105.73.239]:28177 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261295AbSKRBrj>; Sun, 17 Nov 2002 20:47:39 -0500
Date: Sun, 17 Nov 2002 22:10:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021117221045.L1407@almesberger.net>
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com> <20021116193008.C25741@work.bitmover.com> <m11y5k3ruw.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11y5k3ruw.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 17, 2002 at 12:42:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Otherwise the concept gives me security nightmares.

Bah, there are a few Fundamental Truths of Networking Simplification
that we can absolutely rely on:

 - it is perfectly safe to require that a given port be connected only
   to a secure and trusted network
 - if you design a protocol not to work over a WAN, everybody will
   respect this, and deploy it only on LANs
 - if any of the above constraints is no longer tenable, people will
   carefully redesign the protocol in question, and replace the
   installed base
 - all LANs have simple, well-understood characteristics - now and
   forever

After all, SNMP, FSP, LANE, NAT, WEP, etc. can't be wrong (-:C

And yes, I can vividly imagine users of dedicated hosts rush to switch
on that remote console the very moment it becomes available, and use
it across half of the planet.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
