Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUDWWcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUDWWcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUDWWcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:32:25 -0400
Received: from lists.us.dell.com ([143.166.224.162]:34194 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261611AbUDWWcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:32:20 -0400
Date: Fri, 23 Apr 2004 17:29:45 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Subject: Re: [patch 1/3] efivars driver update and move
Message-ID: <20040423222945.GA9594@lists.us.dell.com>
References: <200404221732.i3MHWJcc023373@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <200404221732.i3MHWJcc023373@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2004 at 10:32:19AM -0700, Matt Tolentino wrote:
> Andrew,
>=20
> I broke up the efivars driver update patch I had sent out
> quite a while ago into several smaller patches.  This=20
> includes several fixes and suggestions that were pointed
> out.  The patches are broken down as follows:
>=20
> 2 - add new sysfs based efivars driver into
>     drivers/firmware with accompanying Kconfig/Makefile=20
>     changes to make it fully functional for ia64 again.

Trying these against 2.6.5 + ia64 patch, with efibootmgr-0.5.2-test2.

Works: reading, deleting values.
Doesn't work:  creating and editing values

I note that efibootmgr prints out a warning when it can't read
nonexistant variables, like BootNext.  I'll remove that warning.

It's likely a bug in efibootmgr, as this is the first time I've tried
the sysfs side of things.  If you're in a position to help debug, I'd
appreciate it.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAiZjZIavu95Lw/AkRAs6cAJ4szO5uJGFQD9MxrhUwzTElBJveowCffiwp
rSB2Kfu0L28moKObQEX3OoE=
=1Pdt
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
