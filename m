Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTEMLMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 07:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTEMLMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 07:12:24 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:1918 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S263480AbTEMLMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 07:12:22 -0400
Subject: Re: kernel BUG at inode.c:562!
From: Anders Karlsson <anders@trudheim.com>
To: arjanv@redhat.com
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052824488.4699.0.camel@laptop.fenrus.com>
References: <1052823517.5022.3.camel@tor.trudheim.com>
	 <1052824488.4699.0.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pBUsDoSteR+epS8vM4/r"
Organization: Trudheim Technology Limited
Message-Id: <1052825102.3441.0.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 13 May 2003 12:25:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pBUsDoSteR+epS8vM4/r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-13 at 12:14, Arjan van de Ven wrote:
> On Tue, 2003-05-13 at 12:58, Anders Karlsson wrote:
> > EIP:    0010:[<c01554da>]    Tainted: PF
> > Using defaults from ksymoops -t elf32-i386 -a i386
>=20
> which other modules were in use ?

--(anders@tor)-[1600]-[Tue May 13 12:24:19]-(~)--
$ /sbin/lsmod
Module                  Size  Used by    Tainted: PF=20
i810_audio             25084   1 (autoclean)
ac97_codec             12148   0 (autoclean) [i810_audio]
soundcore               3908   2 (autoclean) [i810_audio]
sr_mod                 14648   0 (autoclean) (unused)
usbserial              19996   0 (autoclean) (unused)
isa-pnp                33488   0 (unused)
vmnet                  19408   6
vmmon                  23676   0 (unused)
hid                    20484   0 (unused)
keybdev                 2180   0 (unused)
ipv6                  163508  -1 (autoclean)
af_packet              13960   1 (autoclean)
ds                      7156   2
yenta_socket           10848   2
pcmcia_core            48416   0 [ds yenta_socket]
mousedev                4628   1
joydev                  6304   0 (unused)
evdev                   4800   0 (unused)
input                   3488   0 [hid keybdev mousedev joydev evdev]
usb-uhci               24208   0 (unused)
ehci-hcd               25708   0 (unused)
usbcore                71852   1 [usbserial hid usb-uhci ehci-hcd]
raw1394                18936   0 (unused)
ohci1394               25936   0 (unused)
ieee1394               47012   0 [raw1394 ohci1394]
e100                   48360   1
ipt_MASQUERADE          1368   1 (autoclean)
ipt_multiport            760   2 (autoclean)
ipt_LOG                 3384   2 (autoclean)
ipt_state                568   5 (autoclean)
iptable_filter          1708   1 (autoclean)
ip_nat_irc              2544   0 (autoclean) (unused)
ip_conntrack_irc        3248   1 (autoclean)
ip_nat_ftp              3280   0 (autoclean) (unused)
iptable_nat            17006   3 (autoclean) [ipt_MASQUERADE ip_nat_irc
ip_nat_ftp]
ip_tables              12288   8 (autoclean) [ipt_MASQUERADE
ipt_multiport ipt_LOG ipt_state iptable_filter iptable_nat]
ip_conntrack_ftp        4272   1 (autoclean)
ip_conntrack           18820   4 (autoclean) [ipt_MASQUERADE ipt_state
ip_nat_irc ip_conntrack_irc ip_nat_ftp iptable_nat ip_conntrack_ftp]
ide-scsi               10832   0
ide-cd                 33408   0
cdrom                  30272   0 [sr_mod ide-cd]
loop                   10264   0 (autoclean)
reiserfs              189872   9
lvm-mod                58752  19


--=-pBUsDoSteR+epS8vM4/r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+wNYOLYywqksgYBoRAvIsAJ4/ti5BAx1xX//g760Srmmv0xqc+QCbBBlH
nxe/0oiZI7Fy5R441Cy3mDA=
=J6EY
-----END PGP SIGNATURE-----

--=-pBUsDoSteR+epS8vM4/r--

