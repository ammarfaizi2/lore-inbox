Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311368AbSCMVBd>; Wed, 13 Mar 2002 16:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311370AbSCMVBX>; Wed, 13 Mar 2002 16:01:23 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:24068 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S311368AbSCMVBK>;
	Wed, 13 Mar 2002 16:01:10 -0500
Date: Wed, 13 Mar 2002 12:55:07 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, Gunther Mayer <gunther.mayer@gmx.net>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
Message-ID: <20020313125507.C38@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0203111436120.14945-100000@weyl.math.psu.edu> <E16kW0A-0001Yl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16kW0A-0001Yl-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 11, 2002 at 08:02:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Umm...  By what magic?  The entire interface _is_ root-only, isn't it?
> > And root can do a lot of fun stuff, starting with editing the kernel
> > image...
> 
> No argument there.
> 
> Do we want to assume all raw commands are CAP_SYS_RAWIO or break them down
> a bit ?

As noone seriously uses capabiities, anyway, I guess CAP_SYS_RAWIO for all
is ok.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

