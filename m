Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSCKTjS>; Mon, 11 Mar 2002 14:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSCKTjI>; Mon, 11 Mar 2002 14:39:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32659 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290184AbSCKTix>;
	Mon, 11 Mar 2002 14:38:53 -0500
Date: Mon, 11 Mar 2002 14:38:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gunther Mayer <gunther.mayer@gmx.net>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <E16kVlK-0001VU-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0203111436120.14945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Alan Cox wrote:

> > Currently your taskfile access is hardcoded in tables in your ide patches and this is
> > 
> > inflexible (e.g. cannot support future commands, unknown at the time of your writing)
> > !
> 
> It stops things like disk level DRM nicely too

Umm...  By what magic?  The entire interface _is_ root-only, isn't it?
And root can do a lot of fun stuff, starting with editing the kernel
image...

