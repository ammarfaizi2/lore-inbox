Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270314AbTGMRUP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270315AbTGMRUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:20:14 -0400
Received: from ip-a1-37024.keycomm.it ([62.152.37.24]:16169 "EHLO
	sparc.campana.vi.it") by vger.kernel.org with ESMTP id S270314AbTGMRUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:20:11 -0400
Date: Sun, 13 Jul 2003 19:34:34 +0200
From: Ottavio Campana <ottavio@campana.vi.it>
To: linux-kernel@vger.kernel.org
Subject: bug in pcmcia + smp + apic?
Message-ID: <20030713173434.GA14231@campana.vi.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux dirac 2.4.21-dirac 
X-Organization: Lega per la soppressione del Visual Basic
X-Homepage: http://www.campana.vi.it/ottavio/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm trying  to use a dlink  dwl 650. On my  laptop with 2.4.18 and  on a
test pc it works with orinoco_cs .

I'm running 2.4.21 on a smp dual athlon and I can't get it working.

I'm already  having some little  problems with  usb on the  computer, it
works only if I pass noapic at  boot time. I thoink about it because the
pci<->pcmcia adapter takes irq 18. The out of /proc/interrupts is

bott@dirac:~/Progetti/quantizzatore-1.0/src > cat /proc/interrupts
           CPU0       CPU1
=2E...
 18:          0          0   IO-APIC-level  Ricoh Co Ltd RL5c475


Doen anyone of you know if there are some problem with apic and pcmcia?

Can you please cc your replies to my address? Thank you.

--=20
Non c'=E8 pi=F9 forza nella normalit=E0, c'=E8 solo monotonia.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/EZgqTVwmA6p94JARAriJAJ0fMpp0rxFStzRJIAIO3mPvUqKdQACfYJH7
Pl+Qaoj2vZ+f9Seatq+efvc=
=mq9k
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
