Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283833AbRLAAEa>; Fri, 30 Nov 2001 19:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283845AbRLAAET>; Fri, 30 Nov 2001 19:04:19 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:40452 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S283833AbRLAAEG>; Fri, 30 Nov 2001 19:04:06 -0500
Date: Sat, 1 Dec 2001 01:03:59 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Mauricio Culibrk <mauricio@infohit.si>, <linux-kernel@vger.kernel.org>
Subject: Re: Device (LAN Cards) Naming
In-Reply-To: <20011130150536.E504@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0112010101090.31465-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Mike Fedyk wrote:

> On Fri, Nov 30, 2001 at 08:57:28PM +0100, Sven Koch wrote:
> > On Fri, 30 Nov 2001, Mauricio Culibrk wrote:
> >
> > > Is it possible to define a name for each interface instead of having
> > > eth0, eth1 etc?
> >
> > ip link set eth0 down
> > ip link set eth0 name buggy
> > ip link set buggy up

> Does the new name work with ifconfig?

Yes, it does.
And with firewalling, shaping, etc - with everything that uses ethX.

Only programs that think they are smarter and use hardcoded
interface-names/schemes/lists are obviously broken.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

