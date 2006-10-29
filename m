Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965333AbWJ2TXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbWJ2TXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWJ2TXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:23:35 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:26839 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S965341AbWJ2TX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:23:29 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCD not readable under 2.6.18
Date: Sun, 29 Oct 2006 21:23:25 +0200
User-Agent: KMail/1.9.5
Cc: wixor <wixorpeek@gmail.com>, linux-kernel@vger.kernel.org
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com> <c43b2e150610191039h504b6000u242cadf8d146de9@mail.gmail.com> <1161349545.26440.19.camel@localhost.localdomain>
In-Reply-To: <1161349545.26440.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3232033.Zrf0sKdSB9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610292123.25776.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3232033.Zrf0sKdSB9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

20 Eki 2006 Cum 16:05 tarihinde, Alan Cox =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> No. It looks to me like an application problem from what has been posted
> so far. Its hard to be sure however. Can you try 2.6.18.1 which fixed
> one or two problems with CD handling that might be enough to have
> confused Xine.

With 2.6.18.1 and with 10 different VCD's (all of them are original copy an=
d=20
they work with my VCD player without a problem) dmesg flooded with followin=
g;

hdb: command error: status=3D0x51 { DriveReady SeekComplete Error }
hdb: command error: error=3D0x50 { LastFailedSense=3D0x05 }
ide: failed opcode was: unknown
ATAPI device hdb:
  Error: Illegal request -- (Sense key=3D0x05)
  Illegal mode for this track or incompatible medium -- (asc=3D0x64, ascq=
=3D0x00)
  The failed "Read 10" packet command was:
  "28 00 00 01 5e ec 00 00 02 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdb, sector 359344
Buffer I/O error on device hdb, logical block 44918
hdb: command error: status=3D0x51 { DriveReady SeekComplete Error }
hdb: command error: error=3D0x50 { LastFailedSense=3D0x05 }
ide: failed opcode was: unknown
ATAPI device hdb:
  Error: Illegal request -- (Sense key=3D0x05)
  Illegal mode for this track or incompatible medium -- (asc=3D0x64, ascq=
=3D0x00)
  The failed "Read 10" packet command was:
  "28 00 00 01 5e ee 00 00 02 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdb, sector 359352
Buffer I/O error on device hdb, logical block 44919
hdb: command error: status=3D0x51 { DriveReady SeekComplete Error }
hdb: command error: error=3D0x50 { LastFailedSense=3D0x05 }
ide: failed opcode was: unknown
ATAPI device hdb:
  Error: Illegal request -- (Sense key=3D0x05)
  Illegal mode for this track or incompatible medium -- (asc=3D0x64, ascq=
=3D0x00)
  The failed "Read 10" packet command was:
  "28 00 00 01 5e ec 00 00 02 00 00 00 00 00 00 00 "
end_request: I/O error, dev hdb, sector 359344
Buffer I/O error on device hdb, logical block 44918

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3232033.Zrf0sKdSB9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRP+ty7E6i0LKo6YRAhvlAJ4qgFxHZ/1GGCLFOfwt7O4cU0gNgQCfSWkr
9GGfrAffxTEUFXevpYrHMDw=
=R056
-----END PGP SIGNATURE-----

--nextPart3232033.Zrf0sKdSB9--
