Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTGXWU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTGXWU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:20:27 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:11270 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271749AbTGXWUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:20:25 -0400
Date: Thu, 24 Jul 2003 15:35:22 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: gaxt <gaxt@rogers.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: Firewire
Message-ID: <20030724223522.GA23196@ruvolo.net>
Mail-Followup-To: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, bcollins@debian.org
References: <3F1FE06A.5030305@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <3F1FE06A.5030305@rogers.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2003 at 09:34:34AM -0400, gaxt wrote:
> Does anyone have firewire running on Linux 2.6.0-test1-mm2 ?

It is not working for me under 2.6.0-test1 (vanilla).  Same hardware works
great under 2.4.20.

> This is what dmesg reports after boot. If I plug in an iPod and use=20
> sbp2, I can mount the iPod as a disk and look at its files but using=20
> gtkpod freezes up the machine.

When I power-on my DV camera, messages like yours pour out, and the kernel
takes up 40% of my CPU time until I turn the camera off.

-Chris

--- module load messages ---
ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 00:0b.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[10]  MMIO=3D[db001000-db0017ff]  Ma=
x Packet=3D[2048]
raw1394: /dev/raw1394 device initialized
ieee1394: Host added: Node[00:1023] GUID[0011060000006a85]  [Linux OHCI-139=
4]
--- end ---

--- power-on DV camera messages ---
ieee1394: Node added: ID:BUS[0-00:1023] GUID[0010950010090143]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10160 ffc10000 00000000 60f30404         =20
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10560 ffc10000 00000000 60f30404         =20
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10960 ffc10000 00000000 60f30404         =20
ieee1394: ConfigROM quadlet transaction error for node 01:1023  =20
ieee1394: The root node is not cycle master capable; selecting a new root n=
ode and resetting...
--- repeats ---
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc03160 ffc00000 00000000 60f30404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: Node removed: ID:BUS[0-00:1023] GUID[0010950010090143]
--- end ---

--- lspci for firewire card ---
00:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Control=
ler (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at db001000 (32-bit, non-prefetchable) [size=3D2K]
        I/O ports at e800 [size=3D128]
        Capabilities: [50] Power Management version 2
--- end ---


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IF8qKO6EG1hc77ERAgyvAJ9Qucftvz5qWuMmVPPnm3FLGlL10gCfcmJY
8ZcnsiKigEAiAwqRhH2hwqg=
=yrZZ
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
