Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUG0Dlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUG0Dlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUG0Dll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:41:41 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:20359 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S266236AbUG0Dlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:41:32 -0400
Message-ID: <4105CEDF.4040009@tequila.co.jp>
Date: Tue, 27 Jul 2004 12:41:19 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040724
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Tim Connors <tconnors+linuxkernel1090893567@astro.swin.edu.au>
CC: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, Joel.Becker@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>	<20040725173652.274dcac6.akpm@osdl.org>	<cone.1090802581.972906.20693.502@pc.kolivas.org>	<20040726202946.GD26075@ca-server1.us.oracle.com>	<20040726134258.37531648.akpm@osdl.org>	<cone.1090882721.156452.20693.502@pc.kolivas.org>	<4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp> <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Connors wrote:
| Clemens Schwaighofer <cs@tequila.co.jp> said on Tue, 27 Jul 2004
10:17:16 +0900:

| Depends on what you do. Do you compile kernels regularly? In
| particular, do you have to wait for them, or do you just let them sit
| in the background, and come back to them when you rememeber, since
| you've been busy doing real work for the past 5 hours? If you wait,
| then I guess you want high swapiness.

well this is a work box. I do coding, yes, but this is perl, php, etc,
mostly (99%) on remote machines. The big apps running here is mozilla,
openoffice, korganzier (yes I do the KDE bloat) and _a_ _lot_ of konsole
~ (kde terminals).

I want responsivness. I don't want to wait 10s to switch between virtual
desktops. I compile a kernel once in a while. Very rare actually,
because this is a work box and I don't reboot all the time (can't &
don't want). The last kernel change was 64d ago.

| For the rest of us who don't have to regularly read in hundreds of
| megs of disk, and don't need to use that hundreds of megs of disk over
| and over and over again (As far as I can see, this is just about
| everyone who's not a kernel developer or some big app developer[1]), I
| guess we get by just fine having smaller swapiness.

well the only thing that needs disk over and over again is this _crappy_
gentoo because it needs to compile everything. I really hate myself for
using it, because _this_ probably screws up _all_ the page cache, etc.

| [1] Maybe kde is bloated enough that you if want to start the equiv of
| an xterm all the time, maybe caching helps a lot there, but I make a
| point of using lean apps[2].

well, to be honest, I doubt it is so bloated anymore. I think gnome is
the better bloat of those two.

| [2] Sad when you consider xemacs lean, isn't it? ;)

well, if you call xemacs (the editor without an OS) lean ... *hmm* but I
am a vim man after all ;)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBc7ejBz/yQjBxz8RAqYwAJoDCBWOxMRXAHHVelV+M9ObQjpsYQCg6a8n
GIRF1+LjDZ+U4TCovnk+RcA=
=K1Xc
-----END PGP SIGNATURE-----
