Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbTCYBqX>; Mon, 24 Mar 2003 20:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTCYBox>; Mon, 24 Mar 2003 20:44:53 -0500
Received: from dial-74.041net.co.yu ([213.240.29.74]:2176 "EHLO azdaha.local")
	by vger.kernel.org with ESMTP id <S261366AbTCYBoW>;
	Mon, 24 Mar 2003 20:44:22 -0500
From: Toplica Tanaskovic <toptan@EUnet.yu>
To: linux-kernel@vger.kernel.org
Subject: [REPRODUCABLE BUGS] Linux 2.5.66
Date: Tue, 25 Mar 2003 02:55:10 +0100
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+b7f+4M6eKBMyOG"
Message-Id: <200303250255.10510.toptan@EUnet.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+b7f+4M6eKBMyOG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

	I've encountered two reproducable bugs, and one feature which can and can =
not=20
be called bug:

1. Radeon frame buffer driver doesn't support mode change in kernel boot=20
params. In 2.6.65 it is OK.

	append line from lilo.conf

    append =3D " hdd=3Dide-scsi video=3Dradeon:1024x768-24@100"

	No mether what is in video=3Dradeon:..., resolution is always set to 80x30=
 with=20
60Hz refresh.

2. Radeon frame buffer mode switching gives unexpected results. When switch=
ing=20
from lower res to higher, switching is ok but you still have old chararcter=
=20
res. eg. 80x30. The text is located in upper left corner, and the right sid=
e=20
off the text area is filled with garbage. Bellow text area there is nothing.
=09
3. Cursor disapears when moving with cursor keys. This is very annoying whe=
n=20
you are editing text for example.

	My config is attached, gcc version is 2.95.3, modutils 2.4.21.
=2D-=20
Regards,
Tanaskovi=C4=87 Toplica



--Boundary-00=_+b7f+4M6eKBMyOG
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
05gcv2P+f3AyWfFbRQAA

--Boundary-00=_+b7f+4M6eKBMyOG--
