Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWFTN7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWFTN7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWFTN7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:59:41 -0400
Received: from mivlgu.ru ([81.18.140.87]:10141 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750991AbWFTN7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:59:40 -0400
Date: Tue, 20 Jun 2006 17:59:38 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Johny <kernel@agotnes.com>, Andrew Morton <akpm@osdl.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net, linux-acpi@vger.kernel.org,
       Alan Stern <stern@rowland.harvard.edu>, Chris Wedgwood <cw@f00f.org>
Subject: Re: [linux-usb-devel] [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB issues]
Message-ID: <20060620135938.GS3206@master.mivlgu.local>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com> <20060620120937.GR3206@master.mivlgu.local> <1150810206.7194.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3sseE1tnmEs+TkKq"
Content-Disposition: inline
In-Reply-To: <1150810206.7194.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3sseE1tnmEs+TkKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2006 at 02:30:06PM +0100, Sergio Monteiro Basto wrote:
> someone has it has a case similar and said that won't work without
> acpi=3Dnoirq
>=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D6654

Yes, acpi=3Dnoirq will work around this bug in many cases, because Linux
will not try to reassign IRQs set up by BIOS.

BTW, the problem may be considered as an ACPI BIOS bug, because
reconfiguring a PCI Interrupt Link should set up IRQ routing, but it
obviously does not.  Unfortunately, this problem seems to be widespread,
so a workaround in kernel is needed.

--3sseE1tnmEs+TkKq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEl/9KW82GfkQfsqIRAmD3AJ4sokTGVa1Jg0XoPrz7ZuUFzLh4TgCfde79
hF9ih77uaAMgGPCHj+8nd/o=
=FerS
-----END PGP SIGNATURE-----

--3sseE1tnmEs+TkKq--
