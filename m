Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbVBFEGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbVBFEGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbVBFEGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:06:31 -0500
Received: from chello062179026180.chello.pl ([62.179.26.180]:42658 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S271990AbVBFEGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:06:12 -0500
Date: Sun, 6 Feb 2005 05:06:41 +0100 (CET)
From: Tomasz Rola <rtomek@ceti.pl>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Otto Wyss <otto.wyss@orpatec.ch>, Marko Macek <Marko.Macek@gmx.net>,
       linux-kernel@vger.kernel.org, Tomasz Rola <rtomek@ceti.pl>
Subject: Re: [OT] Re: Why is debugging under Linux such a pain
In-Reply-To: <DE2864CA-77D9-11D9-BD1C-000393ACC76E@mac.com>
Message-ID: <Pine.LNX.3.96.1050206041937.16513B-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 5 Feb 2005, Kyle Moffett wrote:

> You could also try Xnest, which runs a second X-server within a window 
> of
> the primary X-server,

Yes, this is a good idea...

> except without most of the extra overhead of VNC 

...but I'm not sure if this overhead is noticeable in normal case. I have
just tried to watch film on xvncviewer (same computer, i.e. no network
except localhost) and it was watchable in full screen (800x550 emulated in
window) and even more so when I switched mplayer to window mode. Quake2
also was running quite nicely in 640x400.

BTW, I am using TightVNC and my cpu is Athlon underclocked down to 900
MHz (well, I've decided full 1.8 GHz scared me a lot and besides,
who needs it to run so fast? and why they don't make 7.14 MHz computers
anymore?).

Of course, in terms of cpu cycles, mplayer and Xvnc together took about
35% of CPU in top, while mplayer on real X took only about 3-5% due to the
gfx card doing all the work (seemingly). So the overhead is indeed quite
big.

For a "simple app with few menus", the choice probably doesn't matter
anyway.

> Cheers,
> Kyle Moffett

Regards,
Tomasz Rola

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBQgWX2RETUsyL9vbiEQKLVACgsZeOt11+VUICCITjMBQX9ZTrCQQAoPHa
58IkuL68hTKtZTrQdi70DYV9
=FIkn
-----END PGP SIGNATURE-----


