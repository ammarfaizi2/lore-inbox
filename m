Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbRFNOkD>; Thu, 14 Jun 2001 10:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbRFNOjy>; Thu, 14 Jun 2001 10:39:54 -0400
Received: from sync.nyct.net ([216.44.109.250]:63755 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S263031AbRFNOjl>;
	Thu, 14 Jun 2001 10:39:41 -0400
Date: Thu, 14 Jun 2001 10:45:10 -0400
From: Michael Bacarella <mbac@nyct.net>
To: linux-kernel@vger.kernel.org
Subject: Re: obsolete code must die
Message-ID: <20010614104510.A17690@sync.nyct.net>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com> <E15ARz4-0004Jm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15ARz4-0004Jm-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 08:56:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would it make sense to create some sort of 'make config' script that
> > determines what you want in your kernel and then downloads only those
> > components? After all, with the constant release of new hardware, isn't a
> > 50MB kernel release not too far away? 100MB?
> 
> This should be a FAQ entry.
> 
> For folks doing kernel development a split tree is a nightmare to manage so
> we dont bother. Nothing stops a third party splitting and maintaining the tools
> to download just the needed bits for those who want to do it that way

At the risk of crashing my server, I've written something like this for
my hippy friends who don't have hard drive space.

http://datamorphism.com/linux.cgi

It's very elementary, targetted at extremely savvy people (who are
probably above web interface, go figure :), but it basically allows
one to build a custom kernel archive sans unwanted cpu archs/drivers.

The way it does this is very trivial (exclude directories from
arch or drivers while tarring), but some people have nice results.
The only snags are that the build depends on some driver directories existing
even if you're not using the code in them.

What should probably happen is I wait for CML2, write a web interface to it,
and then build an archive based on whatever users configure.

Anyone want to help out on this? I have some kind of archive caching so
there's only a finite number of possible archives that can be generated,
but my biggest fear is that my machine isn't man enough to handle the
load.

-- 
Michael Bacarella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.
