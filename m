Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132667AbRC2Enh>; Wed, 28 Mar 2001 23:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRC2En1>; Wed, 28 Mar 2001 23:43:27 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:41186 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132667AbRC2EnW>; Wed, 28 Mar 2001 23:43:22 -0500
Date: Wed, 28 Mar 2001 20:43:34 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: <linas@linas.org>
cc: Vojtech Pavlik <vojtech@suse.cz>,
   Gunther Mayer <Gunther.Mayer@t-online.de>, <linas@linas.org>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problems in 2.4.2 -> lost byte
Message-ID: <Pine.LNX.4.31.0103282038120.1748-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The new input psmouse driver can resync when bytes are lost and also
>> shouldn't lose any bytes if there are not transmission problems on the
>> wire. But this is 2.5 stuff.
>
>umm linux kernel 2.5? Umm, given that a stable linux 2.6/3.0 might be
>years away ... and this seems 'minor', wouldn't it be better to
>submit this as a teeny-weeny new kind of mouse device driver as a 2.4.x
>patch?  e.g. CONFIG_MOUSE_PSAUX_SUPERSYNC or something?   I mean this
>cant be more than a few hundred lines of code? Requireing no other
>changes to the kernel?

Its more than a few hundred lines. Mind you it wouldn't be hard to patch
2.4.X to use the new PS/2 drivers but it is a pretty big change. I
seriously don't it would go in. Your welcomed to try out these drivers. I
have personally been using these new PS/2 drivers for several months now
with now problems. In fact this driver can trick my i8042 chipset to allow
me to plug two PS/2 keyboards in :-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

