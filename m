Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWDDVxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDDVxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWDDVxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:53:43 -0400
Received: from threatwall.zlynx.org ([199.45.143.218]:17540 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1750778AbWDDVxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:53:43 -0400
Subject: Re: 2.6.17-rc1-mm1
From: Zan Lynx <zlynx@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Roger Luethi <rl@hellgate.ch>
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eaeH9J7XTkjTyBWHyJco"
Date: Tue, 04 Apr 2006 15:53:37 -0600
Message-Id: <1144187618.26812.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eaeH9J7XTkjTyBWHyJco
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 01:45 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/=
2.6.17-rc1-mm1/

Has anyone seen this yet?

BUG: scheduling while atomic: mii-tool/0x00000001/2968
 <c02db7f7> schedule+0x43/0x540  =20
 <c02dc617> schedule_timeout+0x7a/0x95
 <c011d687> process_timeout+0x0/0x5  =20
 <c011e8a4> msleep+0x1a/0x1f
 <e09100c9> rhine_disable_linkmon+0x40/0xf1 [via_rhine]  =20
 <e09101a6> mdio_read+0x1f/0xab [via_rhine]
 <e08c7443> generic_mii_ioctl+0x6c/0x13f [mii]  =20
 <e0911900> netdev_ioctl+0x2e/0x4e [via_rhine]
 <e09118d2> netdev_ioctl+0x0/0x4e [via_rhine]  =20
 <c02890a7> dev_ifsioc+0x3b8/0x3d2
 <c0289438> dev_ioctl+0x34e/0x47a   =20
 <c027fc63> sock_ioctl+0x0/0x1c0
 <c015b694> do_ioctl+0x1c/0x5d =20
 <c015b917> vfs_ioctl+0x242/0x255
 <c015b954> sys_ioctl+0x2a/0x42 =20
 <c02dd80f> sysenter_past_esp+0x54/0x75

The system also has Intel Ethernet Pro 100 and SiS900 Ethernet
controllers, but only the VIA Rhine driver does this.
--=20
Zan Lynx <zlynx@acm.org>

--=-eaeH9J7XTkjTyBWHyJco
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMurhG8fHaOLTWwgRAkOWAKCgB9j2PioADGukzf+rL6B0cF8v9ACfeGDG
/QlCwVjbG3kiBo7w7TElBws=
=84vg
-----END PGP SIGNATURE-----

--=-eaeH9J7XTkjTyBWHyJco--

