Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUFSKTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUFSKTm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUFSKTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:19:42 -0400
Received: from photon.flashtux.org ([81.56.201.45]:55680 "EHLO photon")
	by vger.kernel.org with ESMTP id S265395AbUFSKTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:19:39 -0400
Date: Sat, 19 Jun 2004 12:19:35 +0200
From: FlashCode <flashcode@flashtux.org>
To: linux-kernel@vger.kernel.org
Subject: USB problems with 2.6.7 kernel / EciAdsl driver
Message-ID: <20040619101934.GA1938@photon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
Organization: FlashTux.org
X-Operating-System: GNU/Linux Debian
X-GPG-Key_fingerprint: 3122 55CC 88BA 5B8A 21FA 3C15 BEC8 E534 520B 673F
X-GPG-Public_key: http://www.flashtux.org/pubkey.txt
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm part of EciAdsl USB ADSL modem driver developers
(http://eciadsl.flashtux.org)
I installed 2.6.7 kernel and I have some problems:
since I upload anything at max speed (15 kb/sec for me), I'm
disconnected after 2-5 sec with this USB error in /var/log/messages:
Jun 19 11:13:18 photon kernel: usb 1-2: bulk timeout on ep2out
Jun 19 11:13:18 photon kernel: usb 1-2: usbfs: USBDEVFS_BULK failed ep
0x2 len 1984 ret -110
No problem when I download sth.

I've tested with 2 machines (same problem), with these USB chipsets:
machine 1:
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 10)
machine 2:
0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev
03)

I tested with noapic option, same usb crash.
Many other people have same problem, maybe not for each upload, but lot
of disconnections with same error in logs..

Finally, I have no problem with 2.6.6 kernel or any older kernel (2.6 or
2.4): connection is very stable.

Feel free to ask me more for testing.
Thanks for any help.

I've not subscribed to LKML, so please CC me for any answer.

--=20
Cordialement / Best regards
Sebastien.

Web: http://www.flashtux.org - email: flashcode@flashtux.org
IRC: FlashCode@irc.freenode.net - Jabber: flashcode@jabber.org

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA1BM2vsjlNFILZz8RAls3AJ4wmqPkMr8WCMP/htZ+5O0kwpuVfACg+JGC
lb3Y+Bgqms4XadU71XZeGzU=
=Ry2x
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
