Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTGYBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGYBp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:45:28 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:37126 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S263025AbTGYBpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:45:25 -0400
Date: Thu, 24 Jul 2003 19:00:27 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725020027.GG23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Torrey Hoffman <thoffman@arnor.net>, gaxt <gaxt@rogers.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <20030725012908.GT1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2003 at 09:29:08PM -0400, Ben Collins wrote:
> Could both you guys try this workaround? Should prove or disprove my
> theory.

Similar output (debug).  Diff of output and then full output follows.

-Chris


--- hork.dmesg.1394     Thu Jul 24 18:54:19 2003
+++ hork.dmesg.1394-2   Thu Jul 24 18:54:45 2003
@@ -12,7 +12,7 @@
 ohci1394_0: Transmit DMA ctx=0 initialized
 ohci1394_0: Transmit DMA ctx=1 initialized
 ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[db001000-db0017ff]  Max Packet=[2048]
-ohci1394_0: request csr_rom address: c0961000
+ohci1394_0: request csr_rom address: c2aca000
 ohci1394_0: IntEvent: 00030010
 ohci1394_0: irq_handler: Bus reset requested
 ohci1394_0: Cancel request received



ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:00:0b.0
ohci1394_0: Remapped memory spaces reg 0xc897a000
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 000000ff
ohci1394_0: 8 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 00110600:00006a85
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=1 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[db001000-db0017ff]  Max Packet=[2048]
ohci1394_0: request csr_rom address: c2aca000
ohci1394_0: IntEvent: 00030010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8956 received
ieee1394: Including SelfID 0x56897f80
ohci1394_0: SelfID for this node is 0x807f8956
ohci1394_0: SelfID complete
ohci1394_0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ieee1394: Initiating ConfigROM request for node 00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00160 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00540 ffc0ffff f0000400
ieee1394: received packet: ffc00540 ffc0ffff f0000400
ieee1394: send packet local: ffc00560 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00560 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 60f30404
ieee1394: send packet local: ffc00940 ffc0ffff f0000400
ieee1394: received packet: ffc00940 ffc0ffff f0000400
ieee1394: send packet local: ffc00960 ffc00000 00000000 60f30404
ieee1394: received packet: ffc00960 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 60f30404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394_0: Starting transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 data=0x1F0000C0 ctx=0

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/II87KO6EG1hc77ERAt0sAKCIOC5Lm0oA/XWfQTf5kf2ciIqIigCbBmo4
cZPTv3pPdV2gCeUPDEq0rMo=
=gzOu
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
