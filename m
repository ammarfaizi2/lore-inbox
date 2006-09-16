Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWIPOwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWIPOwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWIPOwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 10:52:46 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:16069 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1751752AbWIPOwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 10:52:45 -0400
From: Benjamin Schindler <bschindler@student.ethz.ch>
Organization: ETH =?iso-8859-1?q?Z=FCrich?=
To: linux-kernel@vger.kernel.org
Subject: netconsole not working on 2.6.17.6
Date: Sat, 16 Sep 2006 16:51:21 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Message-Id: <200609161651.21357.bschindler@student.ethz.ch>
Content-Type: multipart/signed;
  boundary="nextPart13477184.jsyz1zM1KB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Sep 2006 14:52:43.0843 (UTC) FILETIME=[C4069130:01C6D99F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13477184.jsyz1zM1KB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

I'm unsuccesfully trying to get networking to work - I've got two boxes tha=
t=20
can ping each other: 192.168.0.101 and 192.168.0.102 - I load the netconsol=
e=20
module:

modprobe netconsole=20
netconsole=3D6666@192.168.0.102/eth0,6666@192.168.0.101/00:02:44:34:5d:f6

In dmesg I get:=20

netconsole: local port 6666
netconsole: local IP 192.168.0.102
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.0.101
netconsole: remote ethernet address 00:02:44:34:5d:f6
netconsole: network logging started

I start wireshark/tcpdump whatever - and load a few modules just to produce=
=20
some kernel messages. However, noething leaves the wire but I get all the=20
messages in dmesg.

What's wrong here?

Thanks
Benjamin Schindler

P.s. please cc me as I'm not subscribed to this list

--nextPart13477184.jsyz1zM1KB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFDA9pIExHgErho7kRAkPSAJkBg1xPRgVvua6urLeyUKp0MsrS8ACfff4U
rKzliaftdKbfUqx42Vlascs=
=u+hg
-----END PGP SIGNATURE-----

--nextPart13477184.jsyz1zM1KB--
