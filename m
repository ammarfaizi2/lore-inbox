Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUEMTy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUEMTy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUEMTyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:54:03 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:21636 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S264524AbUEMTgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:36:38 -0400
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: aic79xx trouble
Date: Thu, 13 May 2004 21:36:31 +0200
User-Agent: KMail/1.5.4
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de>
In-Reply-To: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_A58oAGonSlg+XU+";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_A58oAGonSlg+XU+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Oh, I forgot the system specifications:

=2D dual opteron on tyan S2882 board
=2D vanilla linux-2.4.26

Also, is acpi relevant? It is enabled in the kernel-configuration and the t=
he=20
kernel prints quite a lot of error messages when it parses the dsdt.


On Thursday 13 May 2004 21:25, Bernd Schubert wrote:
> Hello,
>
> we are just in the process of setting up a new server, which will serve t=
he
> data of an IDE/SCSI raid system (transtec 5008). Some partions of this ra=
id
> device are also mirrored via drbd to a failover system. During a full
> resync of all (3) failover partitions *from* the failover server, the
> main-server first logs many scsi errors and later the access to the
> raid-partitions completely locks up.
>
> Below is some relevant dmesg output, I already enabled the verbose option
> for the aic79xx driver. Should I also enable debugging, if so, which mode?
>
> Any help is highly appreciated.
>
>
> Thanks in advance,
> 	Bernd
>

--Boundary-02=_A58oAGonSlg+XU+
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAo85ALR5WR6DFumYRAlsQAJ94ORnp1Dm8I/I5hLQbIa05Xi1EkwCgiUXk
Asr6Dvc4Pwd9y6hnQj58R5s=
=P73+
-----END PGP SIGNATURE-----

--Boundary-02=_A58oAGonSlg+XU+--
