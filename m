Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUEGHFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUEGHFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 03:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUEGHFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 03:05:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28555 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262453AbUEGHFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 03:05:14 -0400
Date: Fri, 7 May 2004 09:05:03 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jakma <paul@clubi.ie>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040507070503.GB10600@devserv.devel.redhat.com>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040506195002.520b0793.akpm@osdl.org> <Pine.LNX.4.58.0405070433170.1979@fogarty.jakma.org> <20040506205838.6948a018.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20040506205838.6948a018.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, May 06, 2004 at 08:58:38PM -0700, Andrew Morton wrote:
> Paul Jakma <paul@clubi.ie> wrote:
> >
> > Fair enough but have a look at the other fault from that bug though:
> > 
> >  	https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=99855&action=view 
> > 
> >  That one did not recurse for some reason.
> 
> OK.
> 
> So we're 50 to 60 levels deep in function calls there and simply ran out
> of 4k stack.


no that call trace is AFTER you overflow, eg wrong stack

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAmzUexULwo51rQBIRAtAmAJ9/aDqmceE86kOgJbaBTSAFtDkagACeKp0l
4HtOQeph6g6jYLezBpU/clw=
=S5hR
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
