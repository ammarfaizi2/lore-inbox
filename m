Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSEVOea>; Wed, 22 May 2002 10:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEVOe3>; Wed, 22 May 2002 10:34:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51657 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315170AbSEVOe1>;
	Wed, 22 May 2002 10:34:27 -0400
Date: Wed, 22 May 2002 10:34:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB9A3C.6000102@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0205221033220.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Martin Dalecki wrote:

> > For kbdrate???  sysctl I might see - after all, we are talking about
> > setting two numbers.  ioctl() to pass a couple of integers to the kernel?
> > No, thanks.
> 
> Ahhh and just another note - we are talking about a property of a
> *device* not a property of the kernel - so ioctl (read io as device)
> and certainly not sysctl (read sys as kernel).
> 
> What could be sonsidered as an *serious* alternative would
> be to abstract it out even further and implement it on
> the tset (terminal settings) levels. But *certainly* not sysctl.

Well...  Point about per-device taken, but strictly speaking we
do have e.g. per-interface sysctls, etc.

