Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272259AbTGYTUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272261AbTGYTUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:20:30 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:11272 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S272259AbTGYTUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:20:16 -0400
Date: Fri, 25 Jul 2003 12:35:15 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: gaxt <gaxt@rogers.com>, Torrey Hoffman <thoffman@arnor.net>,
       Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725193515.GQ23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
	Torrey Hoffman <thoffman@arnor.net>,
	Sam Bromley <sbromley@cogeco.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AFQGHouA0VN8Ovbt"
Content-Disposition: inline
In-Reply-To: <20030725184506.GE607@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AFQGHouA0VN8Ovbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2003 at 02:45:06PM -0400, Ben Collins wrote:
> Maybe it wont. Try reverting back to stock, and apply this patch. I am
> pretty sure this will fix the problem for anyone having this issue.

Yes, I think this did it!  One change: needed to change HSBP_VERBOSE to
HSBP_DEBUG in csr.c. =20

I will try turning on my DV camera tonight (I'm remote now) and I'll let you
know how that goes.

-Chris

ieee1394: Initiating ConfigROM request for node 00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00160 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 02a200e0
ieee1394: received packet: ffc00960 ffc00000 00000000 02a200e0
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 00061100
ieee1394: received packet: ffc00d60 ffc00000 00000000 00061100
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 856a0000
ieee1394: received packet: ffc01160 ffc00000 00000000 856a0000
ieee1394: send packet local: ffc01540 ffc0ffff f0000400
ieee1394: received packet: ffc01540 ffc0ffff f0000400
ieee1394: send packet local: ffc01560 ffc00000 00000000 60f30404
ieee1394: received packet: ffc01560 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc01940 ffc0ffff f0000414
ieee1394: received packet: ffc01940 ffc0ffff f0000414
ieee1394: send packet local: ffc01960 ffc00000 00000000 80840300
ieee1394: received packet: ffc01960 ffc00000 00000000 80840300
ieee1394: send packet local: ffc01d40 ffc0ffff f0000418
ieee1394: received packet: ffc01d40 ffc0ffff f0000418
ieee1394: send packet local: ffc01d60 ffc00000 00000000 63400003
ieee1394: received packet: ffc01d60 ffc00000 00000000 63400003
ieee1394: send packet local: ffc02140 ffc0ffff f000041c
ieee1394: received packet: ffc02140 ffc0ffff f000041c
ieee1394: send packet local: ffc02160 ffc00000 00000000 02000081
ieee1394: received packet: ffc02160 ffc00000 00000000 02000081
ieee1394: send packet local: ffc02540 ffc0ffff f0000424
ieee1394: received packet: ffc02540 ffc0ffff f0000424
ieee1394: send packet local: ffc02560 ffc00000 00000000 ab030600
ieee1394: received packet: ffc02560 ffc00000 00000000 ab030600
ieee1394: send packet local: ffc02940 ffc0ffff f0000420
ieee1394: received packet: ffc02940 ffc0ffff f0000420
ieee1394: send packet local: ffc02960 ffc00000 00000000 c083000c
ieee1394: received packet: ffc02960 ffc00000 00000000 c083000c
ieee1394: NodeMgr: raw=3D0xe000a202 irmc=3D1 cmc=3D1 isc=3D1 bmc=3D0 pmc=3D=
0 cyc_clk_acc=3D0 max_rec=3D2048 gen=3D0 lspd=3D2
ieee1394: send packet local: ffc02d40 ffc0ffff f0000400
ieee1394: received packet: ffc02d40 ffc0ffff f0000400
ieee1394: send packet local: ffc02d60 ffc00000 00000000 60f30404
ieee1394: received packet: ffc02d60 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc03140 ffc0ffff f0000414
ieee1394: received packet: ffc03140 ffc0ffff f0000414
ieee1394: send packet local: ffc03160 ffc00000 00000000 80840300
ieee1394: received packet: ffc03160 ffc00000 00000000 80840300
ieee1394: send packet local: ffc03540 ffc0ffff f0000418
ieee1394: received packet: ffc03540 ffc0ffff f0000418
ieee1394: send packet local: ffc03560 ffc00000 00000000 63400003
ieee1394: received packet: ffc03560 ffc00000 00000000 63400003
ieee1394: send packet local: ffc03940 ffc0ffff f000041c
ieee1394: received packet: ffc03940 ffc0ffff f000041c
ieee1394: send packet local: ffc03960 ffc00000 00000000 02000081
ieee1394: received packet: ffc03960 ffc00000 00000000 02000081
ieee1394: send packet local: ffc03d40 ffc0ffff f0000424
ieee1394: received packet: ffc03d40 ffc0ffff f0000424
ieee1394: send packet local: ffc03d60 ffc00000 00000000 ab030600
ieee1394: received packet: ffc03d60 ffc00000 00000000 ab030600
ieee1394: send packet local: ffc04140 ffc0ffff f0000428
ieee1394: received packet: ffc04140 ffc0ffff f0000428
ieee1394: send packet local: ffc04160 ffc00000 00000000 00000000
ieee1394: received packet: ffc04160 ffc00000 00000000 00000000
ieee1394: send packet local: ffc04540 ffc0ffff f000042c
ieee1394: received packet: ffc04540 ffc0ffff f000042c
ieee1394: send packet local: ffc04560 ffc00000 00000000 00000000
ieee1394: received packet: ffc04560 ffc00000 00000000 00000000
ieee1394: send packet local: ffc04940 ffc0ffff f0000430
ieee1394: received packet: ffc04940 ffc0ffff f0000430
ieee1394: send packet local: ffc04960 ffc00000 00000000 756e694c
ieee1394: received packet: ffc04960 ffc00000 00000000 756e694c
ieee1394: send packet local: ffc04d40 ffc0ffff f0000434
ieee1394: received packet: ffc04d40 ffc0ffff f0000434
ieee1394: send packet local: ffc04d60 ffc00000 00000000 484f2078
ieee1394: received packet: ffc04d60 ffc00000 00000000 484f2078
ieee1394: send packet local: ffc05140 ffc0ffff f0000438
ieee1394: received packet: ffc05140 ffc0ffff f0000438
ieee1394: send packet local: ffc05160 ffc00000 00000000 312d4943
ieee1394: received packet: ffc05160 ffc00000 00000000 312d4943
ieee1394: send packet local: ffc05540 ffc0ffff f000043c
ieee1394: received packet: ffc05540 ffc0ffff f000043c
ieee1394: send packet local: ffc05560 ffc00000 00000000 00343933
ieee1394: received packet: ffc05560 ffc00000 00000000 00343933
ieee1394: send packet local: ffc05940 ffc0ffff f0000420
ieee1394: received packet: ffc05940 ffc0ffff f0000420
ieee1394: send packet local: ffc05960 ffc00000 00000000 c083000c
ieee1394: received packet: ffc05960 ffc00000 00000000 c083000c
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006a85]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 63:1023, tlabel=3D0, tcode=3D0x0, spe=
ed=3D0
ohci1394_0: Starting transmit DMA ctx=3D0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=3D0x00008011
ohci1394_0: Packet sent to node 63 tcode=3D0x0 tLabel=3D0x00 ack=3D0x11 spd=
=3D0 data=3D0x1
F0000C0 ctx=3D0


--AFQGHouA0VN8Ovbt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IYZyKO6EG1hc77ERAnjKAKDLgdUqPaXer0h25hQjwE6ZmsqBFQCg/RZd
GRhRLK3AdPfsCs3FYCiVQpA=
=INnq
-----END PGP SIGNATURE-----

--AFQGHouA0VN8Ovbt--
