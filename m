Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275714AbRI0AMh>; Wed, 26 Sep 2001 20:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275717AbRI0AM1>; Wed, 26 Sep 2001 20:12:27 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:11787 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S275714AbRI0AMU>; Wed, 26 Sep 2001 20:12:20 -0400
Message-ID: <3BB26E5F.23BD5787@osdlab.org>
Date: Wed, 26 Sep 2001 17:10:07 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Peter Sandstrom <peter@zaphod.nu>, Robert Cantu <robert@tux.cs.ou.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: Etherenet Link Detection
In-Reply-To: <200109262349.f8QNnju14536@www.hockin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> > It's traditionally been defined as MII information, but that's
> > awfully slow, so some Ethernet controllers make it available
> > in a quicker manner.
> >
> > ethtool might do this (http://sourceforge.net/projects/gkernel/);
> > I don't know for sure.
> 
> The only interface to this is through MII, unless we want to add an ETHTOOL
> style ioctl to get the link status.  This means, however, that every driver
> that wants to report this needs to support at least a subset of ethtool
> ioctls, which VERY FEW do.

Right.  I think that Jeff was thinking about this for 2.5 (what's
that?),
but I'm not trying to speak for Jeff.

Or maybe this has already been discussed on these mailing lists:
  linux-net@vger.kernel.org or netdev@oss.sgi.com

~Randy
