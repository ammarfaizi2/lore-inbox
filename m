Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVGBTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVGBTQV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVGBTQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 15:16:21 -0400
Received: from smtp1.irishbroadband.ie ([62.231.32.12]:26583 "EHLO
	smtp1.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S261264AbVGBTQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 15:16:08 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <tony@vroon.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120331026.22021.2.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>  <1120325613.5073.16.camel@mulgrave>
	 <1120326423.22057.3.camel@localhost>  <1120329389.5073.21.camel@mulgrave>
	 <1120331026.22021.2.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uiSMNF8igGd0peSFX7Sf"
Date: Sat, 02 Jul 2005 20:15:14 +0100
Message-Id: <1120331714.22021.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uiSMNF8igGd0peSFX7Sf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-07-02 at 20:03 +0100, Tony Vroon wrote:
> Output follows:
It got mangled somehow. Not sure what happened but it's corrupted near
the end. Reposting:
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

scsi0: Slave Alloc 0
(scsi0:A:0:0): Sending WDTR 0
(scsi0:A:0:0): Received WDTR 0 filtered to 0
 target0:0:0: FAST-5 SCSI 1.0 MB/s ST (1020 ns, offset 255)
scsi0: target 0 using 8bit transfers
(scsi0:A:0:0): Sending SDTR period 45, offset 0
(scsi0:A:0:0): Received SDTR period 45, offset 0
Filtered to period 0, offset 0
 target0:0:0: asynchronous.
scsi0: target 0 using asynchronous transfers
 Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: Slave Configure 0
 target0:0:0: asynchronous.
scsi0:A:0:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
(scsi0:A:0:0): Sending WDTR 1
(scsi0:A:0:0): Received WDTR 1 filtered to 1
 target0:0:0: FAST-5 WIDE SCSI 2.0 MB/s ST (1020 ns, offset 255)
scsi0: target 0 using 16bit transfers
(scsi0:A:0:0): Sending SDTR period 45, offset 0
(scsi0:A:0:0): Received SDTR period 45, offset 0
Filtered to period 0, offset 0
 target0:0:0: wide asynchronous
csi0: target 0 using asynchronous transfers
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
7
(scsi0:A:0:0): Received PPR bus_width 1, period 9, offset 7f,
ppr_options 7
Filtered to width 1, period 9, offset 7f, options 7
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s ST IU (12.5ns, offset 127)
scsi0: target 0 synchronous at 80.0MHz DT, offset =3D 0x7
(scsi0:A:0:0): Unexpected busfree in Message-in phase
SEQADDR =3D=3D 0x16b
 target0:0:0: Write Buffer failure 70000
 target0:0:0: Domain Validation Disabling Information Units
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
6
(scsi0:A:0:0): refuses tagged comands.  Performing non-tagged I/O
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s ST IU (12.5 ns, offset 127)
*PC hangs here*


--=-uiSMNF8igGd0peSFX7Sf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCxufCp5vW4rUFj5oRAny6AJsEh4PD8cIiKrjATgkNKsqQvBgaEACgwbkP
w0yP96781dZGOKAxW2nEc48=
=NeAK
-----END PGP SIGNATURE-----

--=-uiSMNF8igGd0peSFX7Sf--

