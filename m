Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132194AbRCaEPQ>; Fri, 30 Mar 2001 23:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRCaEPH>; Fri, 30 Mar 2001 23:15:07 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:42644 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132194AbRCaEO6>; Fri, 30 Mar 2001 23:14:58 -0500
Date: Fri, 30 Mar 2001 20:15:20 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0103302012490.743-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The console driver does not actually use 2.5MB.  Does it make sense to
>use an MTRR for the smaller power-of-two region?

If we implement a font cache in the future it could. Also that extra
memory is used to allow scrollback. We could break up the size of the
region. Have it a*2^n+b*2^(n-1)+c*2^(n-2)+... = 2.5 MB. Isn't math grand
:-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

