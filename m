Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316251AbSEVQcx>; Wed, 22 May 2002 12:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316252AbSEVQcw>; Wed, 22 May 2002 12:32:52 -0400
Received: from www.transvirtual.com ([206.14.214.140]:26632 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316251AbSEVQcu>; Wed, 22 May 2002 12:32:50 -0400
Date: Wed, 22 May 2002 09:31:51 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alexander Viro <viro@math.psu.edu>, Vojtech Pavlik <vojtech@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB9A3C.6000102@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10205220931260.4611-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

Hm. That is a interesting idea. I like it.

