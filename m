Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270412AbTGZQiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270425AbTGZQiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:38:10 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:50953 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S270412AbTGZQiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:38:06 -0400
Date: Sat, 26 Jul 2003 09:52:59 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: gaxt <gaxt@rogers.com>, Torrey Hoffman <thoffman@arnor.net>,
       Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030726165259.GV23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
	Torrey Hoffman <thoffman@arnor.net>,
	Sam Bromley <sbromley@cogeco.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net> <20030725201128.GA535@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uUozbLrG2OP+gMtx"
Content-Disposition: inline
In-Reply-To: <20030725201128.GA535@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uUozbLrG2OP+gMtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2003 at 04:11:29PM -0400, Ben Collins wrote:
> Kick ass. I've commited this change to the 1394 repo. Linus will get the
> fix soon. I'll also send it to Marcelo for 2.4.22.
>=20
> Please, if you are testing, use the code at www.linux1394.org's viewcvs
> (trunk tarball will replace drivers/ieee1394 in 2.6, branches/linux-2.4
> will do the same for 2.4).

Its all working!  Compiled the 1014 rev, and everything looks good.  dvgrab,
kino, gscanbus, even GnomeMeeting 0.98 with /dev/video1394.

Thanks for all your help, and the time spent tracking down this problem!

-Chris

ohci1394: $Rev$ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:00:0b.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[10]  MMIO=3D[db001000-db0017ff]  Ma=
x Packet=3D[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006a85]
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0010950010090143]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[0010950010090143]


--uUozbLrG2OP+gMtx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IrHrKO6EG1hc77ERAsjqAJ9mX8wEs9RT80FKQ+wGLTQYnuxqlwCcDK0A
SKxoKRFHqrDMHkuCSY4S31A=
=BQHA
-----END PGP SIGNATURE-----

--uUozbLrG2OP+gMtx--
