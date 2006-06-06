Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWFFHpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWFFHpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWFFHpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:45:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:6831 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932120AbWFFHpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:45:51 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Linux Kernel Mailing List, " <linux-kernel@vger.kernel.org>
Subject: PCIE region size issue?
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Date: Tue, 6 Jun 2006 17:46:50 +1000
Content-Type: multipart/signed;
  boundary="nextPart20530816.KKb2EQmZgo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606061746.55391.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart20530816.KKb2EQmZgo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

I purchased an AMD64 laptop last December, and have never had perfect succe=
ss=20
in getting suspend to disk to work reliably. I thought maybe I had a bug in=
=20
Suspend2, but careful diagnosis kept pointing in the direction of drivers. =
In=20
addition, from time to time, the screen goes plain white and the system sto=
ps=20
responding, requiring a hard power off.

The other day, I saw a report of bios settings for the uma aperature not=20
matching what Linux was detecting. I checked my machine, and found that thi=
s=20
issue is occuring here. If I set the bios to 32 meg, lspci says it's 64, an=
d=20
so on. If I set the bios to 256 meg, the system is unbootable. (Forgive me =
if=20
my terminology is a bit messed up - I'm not a pci expert!).

I've seen a number of other reports of issues with pci region sizes, not=20
always graphics related.

http://www.linuxforums.org/forum/redhat-fedora-linux-help/32870-pci-failed-=
allocate-mem-resource-error-pcie-fc3-64bit.html
http://linux.derkeiler.com/Mailing-Lists/Fedora/2005-11/4702.html
http://www.nvnews.net/vbulletin/showthread.php?t=3D42597&page=3D5

I'm therefore wondering, could there be some bug in the sizing of regions=20
that's leading to the sizes being doubled?

I have also emailed my laptop manufacturer to see if there are any bios=20
updates available.

Regards,

Nigel
=2D-
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart20530816.KKb2EQmZgo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhTLvN0y+n1M3mo0RAiKeAJ9GIuMpy5Btk0iHSW16unZMqK4s9wCdEXGo
QaZ9vnHzUclJGqvagDwJuNI=
=4Ogh
-----END PGP SIGNATURE-----

--nextPart20530816.KKb2EQmZgo--
