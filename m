Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbTEKOfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEKOfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:35:32 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:46295 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261577AbTEKOf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:35:28 -0400
Date: Sun, 11 May 2003 16:48:09 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: isapnp and 2.5.69
Message-Id: <20030511164809.525df433.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
X-Outlook: <html><form><input type crash></form></html>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.mQtC6P1_yMdmDp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.mQtC6P1_yMdmDp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hello,

Trying to run 2.5.69 on an old P133 with ISA Soundblaster 32 AWE PnP I hit
the following kernel bug.

Regards,
-Udo.

Linux version 2.5.69 (root@Sorisor) (gcc version 3.2.2) #1 Sat May 10 16:45:35 CEST 2003
[...]
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
irq 5: nobody cared!
Call Trace:
 [<c010a618>] handle_IRQ_event+0x78/0xe0
 [<c010a833>] do_IRQ+0xa3/0x140
 [<c0109158>] common_interrupt+0x18/0x20
 [<c010ae2d>] setup_irq+0x9d/0x100
 [<c02074b0>] pnp_test_handler+0x0/0x10
 [<c010a947>] request_irq+0x77/0xb0
 [<c020758b>] pnp_check_irq+0xcb/0x120
 [<c02074b0>] pnp_test_handler+0x0/0x10
 [<c0207d12>] pnp_next_irq+0xa2/0xf0
 [<c02081f9>] pnp_next_request+0x179/0x2a0
 [<c020838f>] pnp_next_config+0x6f/0xc0
 [<c0208460>] pnp_advanced_config+0x80/0x130
 [<c02087c6>] pnp_auto_config_dev+0x36/0x40
 [<c0206037>] __pnp_add_device+0x97/0xc0
 [<c0206404>] pnp_add_card+0xf4/0x150
 [<c03e72a1>] isapnp_build_device_list+0x161/0x190
 [<c03e73e9>] isapnp_init+0x119/0x280
 [<c03da6ab>] do_initcalls+0x2b/0xa0
 [<c010509f>] init+0x2f/0x190
 [<c0105070>] init+0x0/0x190
 [<c0107009>] kernel_thread_helper+0x5/0xc

handlers:
[<c02074b0>] (pnp_test_handler+0x0/0x10)
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total

--=.mQtC6P1_yMdmDp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+vmKpnhRzXSM7nSkRAswoAJwNsE5blKv5Dd5WNEQcruNB4dab/ACfZq/y
JFBN9ZIMueMpddclOMOLfF8=
=E3th
-----END PGP SIGNATURE-----

--=.mQtC6P1_yMdmDp--
