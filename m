Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270575AbRHNLtv>; Tue, 14 Aug 2001 07:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270573AbRHNLtn>; Tue, 14 Aug 2001 07:49:43 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:24595 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270577AbRHNLtg>; Tue, 14 Aug 2001 07:49:36 -0400
Date: Sat, 11 Aug 2001 01:11:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andreas Haumer <andreas@xss.co.at>
Cc: "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Swapping for diskless nodes
Message-ID: <20010811011146.B55@toy.ucw.cz>
In-Reply-To: <E15Ulnx-0006zZ-00@the-village.bc.nu> <3B729B96.D306185C@dirksteinberg.de> <3B729FD7.7D8BCA5F@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B729FD7.7D8BCA5F@xss.co.at>; from andreas@xss.co.at on Thu, Aug 09, 2001 at 04:36:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > what you say sound a lot like a hacker solution ("check that it uses the
> > right GFP_ levels"). I think it's about time that this deficit of linux
> > as compared to SunOS or *BSD should be removed. Network paging should be
> > supported as a standard feature of a stock kernel compile.
> > 
> We have swapping over NBD running for some time now on
> our "xS+S Diskless Client" system, and it works really
> fine! No problem running StarOffice, Netscape, The Gimp
> and KDE on a 128MB Diskless Client and 250MB swap over a 
> 100MBit switched ethernet!

Try going 8MB of ram, ping -f client and try to compile the kernel.

Netscape + SO + gimp on 128MB is rather light load.

> Check <http://www.xss.co.at/linux/NBD/Applications.html>
> to find our solution for that.
> 
> Kernel patches are a little bit outdated, but we have NBD swap
> for 2.2.19 running internally since this week, and we will
> update our web-page soon.

Be sure to mail me a copy.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

