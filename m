Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277055AbRJVQvs>; Mon, 22 Oct 2001 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277064AbRJVQvi>; Mon, 22 Oct 2001 12:51:38 -0400
Received: from www.transvirtual.com ([206.14.214.140]:39178 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277055AbRJVQvZ>; Mon, 22 Oct 2001 12:51:25 -0400
Date: Mon, 22 Oct 2001 09:51:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Tim Jansen <tim@tjansen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <15vO3W-0DSqTwC@fmrl00.sul.t-online.com>
Message-ID: <Pine.LNX.4.10.10110220950310.1738-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It sets the hardware state of the keyboards and the
> > mice. The user runs apps that alter the state. The second user comes along
> > and log in on desktop two. He runs another small application to test the
> > mice. It changes the state which in turn effects the person on desktop
> > one.
> 
> Isn't this a driver problem? 

That is what I'm pointing out. 

> If two processes can interfere when using the 
> same device the driver should only allow one access (one device file opened) 
> at a time. 

That is the current solution.

> And if two processes need to access it it should be managed by a 
> daemon. 

And if the daemon dies you could end up with a broken mouse if using force
feedback. 

