Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRDAPkp>; Sun, 1 Apr 2001 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDAPk0>; Sun, 1 Apr 2001 11:40:26 -0400
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:64238 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132137AbRDAPkU>; Sun, 1 Apr 2001 11:40:20 -0400
Date: Sun, 1 Apr 2001 07:40:36 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: <thunder7@xs4all.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [lkml]Re: Matrox G400 Dualhead
Message-ID: <Pine.LNX.4.31.0104010737420.736-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>If I use X on an accelerated, normal Matrox screen, my monitor complains
>on exit:
>
>fH 49.4 KHz, fV 39.8 Hz
>
>(and it doesn't sync at 40 Hz vertical refresh :-( ).
>
>This is _half_ of the normal 80 Hz. Using fbset -a "1600x1200-80" before
>X, of after X, doesn't do anything. Does anybody know what to hack out
>in X to get it to _not_ reset my G400 to some unusable state? 3.3.6 was
>didn't do this. I can use the framebuffer-screen just fine, but I miss
>the DGA extension.

Try adding this to your XF86Config file:

Section "Device"
...
Option UseFBDev
...
EndSection


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

