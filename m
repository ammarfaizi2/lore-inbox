Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272241AbTGYR6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272237AbTGYR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:58:05 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:61191 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S272271AbTGYR6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:58:01 -0400
Date: Fri, 25 Jul 2003 11:13:03 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Ben Collins <bcollins@debian.org>, Sam Bromley <sbromley@cogeco.ca>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725181303.GO23196@ruvolo.net>
Mail-Followup-To: Torrey Hoffman <thoffman@arnor.net>,
	Ben Collins <bcollins@debian.org>, Sam Bromley <sbromley@cogeco.ca>,
	gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvuFargmsA+C2jC8"
Content-Disposition: inline
In-Reply-To: <1059155483.2525.16.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mvuFargmsA+C2jC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2003 at 10:51:24AM -0700, Torrey Hoffman wrote:
> So, I applied Ben's last patch, added an extra debug line to print
> jiffies, expire, and packet->sendtime in abort_timedouts, and enabled
> the "excessive debugging output" config option.=20

> 02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Contr=
oller (rev 46)

Seems that you and I have the same 1394 chipset.  I'm curious to see the=20
output from a "lspci -v -s02:0b.0".

-Chris

00:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Control=
ler (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at db001000 (32-bit, non-prefetchable) [size=3D2K]
        I/O ports at e800 [size=3D128]
        Capabilities: [50] Power Management version 2


--mvuFargmsA+C2jC8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IXMuKO6EG1hc77ERAoyEAJ9mU+qbcWo57L8GR5YWS68mXKb37ACfRhux
+kEMHKXudLI2h5J5UkkPCeY=
=fGE+
-----END PGP SIGNATURE-----

--mvuFargmsA+C2jC8--
