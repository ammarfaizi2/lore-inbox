Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTFCSNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFCSNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:13:53 -0400
Received: from newmail.somanetworks.com ([216.126.67.42]:34236 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S261678AbTFCSNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:13:51 -0400
Date: Tue, 3 Jun 2003 14:27:12 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Ben Collins <bcollins@debian.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-Id: <20030603142712.6e7da879.georgn@somanetworks.com>
In-Reply-To: <1054663917.4967.99.camel@jma1.dev.netgem.com>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
	<20030602163443.2bd531fb.georgn@somanetworks.com>
	<1054588832.4967.77.camel@jma1.dev.netgem.com>
	<20030603113636.GX10102@phunnypharm.org>
	<1054663917.4967.99.camel@jma1.dev.netgem.com>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.m1NEb7Ne8q.kwg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.m1NEb7Ne8q.kwg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 03 Jun 2003 20:11:57 +0200
Jocelyn Mayer <jma@netgem.com> wrote:

> Thanks for your help, but I think you're wrong:

I doubt it.  Ben's one of the authorities on this stuff.

> First, I never trust hotplug or other tools like this:
> I do all insmod by hand, so I know all drivers have been loaded.
> What is hotplug supposed to do (but wasn't in previous driver
> version...) ?

I compile this stuff directly into my kernel.  Doesn't make a
difference.

> The second thing I see is that it used to work,
> before 2.4.21-rc2. The only difference is in the kernel driver,
> so it should work with no user-space tool, as it used to.
> If not, the driver is now buggy...

Well, I've _always_ needed either rescan-scsi-bus.sh (or scsiadd -s
since I switched to Debian).  If there's some magic that you've been
doing that obviates this requirement, we're all ears.

-g

--=.m1NEb7Ne8q.kwg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3OiAoJNnikTddkMRAmefAKCLcFeSCPUL9oVau0Fk6V7VA2QrkwCeJ8fM
E+VdDhki9QhDJcpRY1heTSU=
=avXE
-----END PGP SIGNATURE-----

--=.m1NEb7Ne8q.kwg--
