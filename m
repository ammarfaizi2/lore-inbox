Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUEVSiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUEVSiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 14:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUEVSiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 14:38:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261786AbUEVSiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 14:38:09 -0400
Subject: Re: Trouble with NFS with -mm3, -mm4, and -mm5
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jim Gifford <maillist@jg555.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <01ef01c44027$7cb90920$d100a8c0@W2RZ8L4S02>
References: <01ef01c44027$7cb90920$d100a8c0@W2RZ8L4S02>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mirywpEWsTkHQBcA+oV3"
Organization: Red Hat UK
Message-Id: <1085251081.14486.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 22 May 2004 20:38:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mirywpEWsTkHQBcA+oV3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-05-22 at 20:06, Jim Gifford wrote:
> I keep getting the following oops using NFS with -mm3 thru -mm5.
>=20
> May 22 00:25:27 server ------------[ cut here ]------------
> May 22 00:25:27 server kernel BUG at include/linux/dcache.h:276!
> May 22 00:25:27 server invalid operand: 0000 [#1]
> May 22 00:25:27 server PREEMPT SMP
> May 22 00:25:27 server Modules linked in: vfat fat isofs zlib_inflate flo=
ppy
> ext2 videodev nfsd exportfs lockd sunrpc parport_pc lp parport ipt_TOS
> ipt_TCPMSS ipt_LOG ipt_limit iptable_mangle iptable_nat ip_conntrack_irc
> ip_conntrack_ftp ipt_REJECT ipt_state ip_conntrack af_packet bonding 8250
> serial_core ohci_hcd usbcore psmouse tulip crc32 iptable_filter ip_tables
> ovcamchip i2c_core rtc supermount unix aic7xxx megaraid sd_mod scsi_mod

does this happen without supermount too? It might just be that something
is confusing the VFS..... and thus the bug in dcache...

--=-mirywpEWsTkHQBcA+oV3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAr54JxULwo51rQBIRAuyJAJ9aD8SiJk4a40DChl/n4HQSY17fuQCdElXK
ZiiOS3rZBCiKVTPgQxIKn+U=
=8d1M
-----END PGP SIGNATURE-----

--=-mirywpEWsTkHQBcA+oV3--

