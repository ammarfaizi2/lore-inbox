Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTKGWmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTKGW04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15062 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264647AbTKGV7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:34 -0500
Date: Fri, 7 Nov 2003 16:22:36 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
cc: =?koi8-r?Q?=22?=Larry McVoy=?koi8-r?Q?=22=20?= <lm@bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: linux.bkbits.net down=?koi8-r?Q?=3F?=
In-Reply-To: <E1AHiDl-0000It-00.arvidjaar-mail-ru@f20.mail.ru>
Message-ID: <Pine.LNX.4.44.0311071620000.26538-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, [koi8-r] "Andrey Borzenkov[koi8-r] "  wrote:

> 
> 
> 
> -----Original Message-----
> 
> > 
> > bkbits is definitely up but we did switch T1 providers recently.
> > That included changing the routes in the backbone.  The only thing I can
> > think of is that your part of the backbone does not have a route for us.
> > We're 192.132.92.*, see if you can traceroute to us.
> > 
> 
> I can't traceroute behind NAT firewall but I can ping it no problems:
> 
> root@student8:/#> ping linux.bkbits.net
> linux.bkbits.net is alive
> 
> the problem is attempt to enter any repository there (linux-2.5, linux-2.4
> or the third, I forgot) just times out.

See if the URLs that fail on you contain the 8080 port specifier.
Most probably your firewall is blocking those.


Nicolas

