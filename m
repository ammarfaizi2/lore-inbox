Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSL1Fqa>; Sat, 28 Dec 2002 00:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSL1Fqa>; Sat, 28 Dec 2002 00:46:30 -0500
Received: from 52-32.congress.ccc.de ([213.173.52.32]:1664 "HELO
	schottelius.net") by vger.kernel.org with SMTP id <S265523AbSL1Fq0>;
	Sat, 28 Dec 2002 00:46:26 -0500
Date: Sat, 28 Dec 2002 02:16:30 +0000
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.21pre2 trident / ali5451
Message-ID: <20021228021630.GA324@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.4.21-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

trident.o doesn load anymore...
while trying to insert it, the whole system hangs.

flapp:/home/user/nico/ccc/video # modprobe trident
/lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: init_module: No su=
ch device
Hint: insmod errors can be caused by incorrect module parameters, including=
 invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: insmod /lib/module=
s/2.4.21-pre2/kernel/drivers/sound/trident.o failed
/lib/modules/2.4.21-pre2/kernel/drivers/sound/trident.o: insmod trident fai=
led

pp:/home/user/nico/ccc/video # lspci  -n=20
00:00.0 Class 0600: 10b9:1621 (rev 05)
00:01.0 Class 0604: 10b9:5247 (rev 01)
00:06.0 Class 0401: 10b9:5451 (rev 01)
00:07.0 Class 0601: 10b9:1533
00:0a.0 Class 0200: 8086:1229 (rev 08)
00:10.0 Class 0101: 10b9:5229 (rev c3)
00:11.0 Class 0680: 10b9:7101
00:13.0 Class 0607: 1217:6933 (rev 01)
00:13.1 Class 0607: 1217:6933 (rev 01)
00:14.0 Class 0c03: 10b9:5237 (rev 03)
01:00.0 Class 0300: 1002:4c4d (rev 64)


In 2.4.19 it worked, in 2.5.53 the alsa device works, but trident not, agai=
n.

Greetings,

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+DQl+tnlUggLJsX0RAughAJ44FpW12w2a222SQaqFxsQ5Xupz6wCdHoU5
HtB6emC0oR022/fyUh+mUAo=
=d0Hd
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
