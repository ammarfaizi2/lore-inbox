Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267735AbTBUWIy>; Fri, 21 Feb 2003 17:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTBUWIy>; Fri, 21 Feb 2003 17:08:54 -0500
Received: from adsl-67-123-8-233.dsl.pltn13.pacbell.net ([67.123.8.233]:1504
	"EHLO influx.triplehelix.org") by vger.kernel.org with ESMTP
	id <S267735AbTBUWIx>; Fri, 21 Feb 2003 17:08:53 -0500
Date: Fri, 21 Feb 2003 14:18:14 -0800
From: Joshua Kwan <joshk@saltbox.argot.org>
To: hostap@shmoo.com
Cc: linux-kernel@vger.kernel.org, dhinds@sonic.net
Subject: 2.5 weirdness
Message-ID: <20030221221814.GA1316@triplehelix.org>
Reply-To: joshk@triplehelix.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I was wondering if any people might know what is going on here. This
happens in 2.5.62, using CardBus pcmcia support within my kernel and
the latest pcmcia-cs snapshot.

Just to clarify, I have only one wifi card - wlan0.

cardmgr[99]: starting, version is 3.2.4
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cardmgr[99]: socket 0: U.S. Robotics IEEE 802.11b PC-CARD
cardmgr[99]: executing: 'modprobe hostap_crypt'
cardmgr[99]: executing: 'modprobe hostap'
cardmgr[99]: executing: 'modprobe hostap_cs'
hostap_cs: 0.0.0 CVS (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_cs: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
hostap_cs: Registered netdevice wlan0
wlan0: NIC: id=3D0x8002 v1.0.0
wlan0: PRI: id=3D0x15 v0.3.0
wlan0: STA: id=3D0x1f v1.4.9
cardmgr[99]: executing: './network start wlan0'
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... spurious 8259A interrupt: IRQ7.
cardmgr[99]: + Debian network setup
done.
cardmgr[99]: + /sbin/pump -i wlan0
cardmgr[99]: + /sbin/ifup wlan0
cardmgr[99]: + /sbin/ifup: interface wlan0 already configured
cardmgr[99]: socket 1: U.S. Robotics IEEE 802.11b PC-CARD
wlan0: Interrupt, but SWSUPPORT0 does not match: FFFF !=3D 8A32 - card remo=
ved?
hostap_cs: index 0x01: Vcc 5.0, irq 5, io 0x0180-0x01bf
hostap_cs: wlan0: resetting card
wlan0: hfa384x_cmd - timeout - reg=3D0xffff
hostap_cs: first command failed - is the card compatible?
hostap_cs: Initialization failed
hostap_cs: Registered netdevice wlan1
wlan1: NIC: id=3D0x8002 v1.0.0
wlan1: PRI: id=3D0x15 v0.3.0
wlan1: STA: id=3D0x1f v1.4.9
cardmgr[99]: executing: './network start wlan1'
cardmgr[99]: + Debian network setup
cardmgr[99]: + /sbin/pump -i wlan1

It worked well in 2.5.61, I think. What changed? (Actually, in 2.5.60, it
had a different kind of problem, it would recognize the card as a memory_cs
device, but that was fixed.)

Regards
Josh
--=20
New PGP public key: 0x27AFC3EE

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+VqWlT2bz5yevw+4RAlPeAJ9iSZXfUt9QOANNbDINEs8nRNGYRwCdFBGA
oaeg3xp/xVWbJ5Rfwoe2DNQ=
=4Zhw
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
