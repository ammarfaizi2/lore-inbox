Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVGBRuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVGBRuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVGBRuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:50:25 -0400
Received: from smtp2.irishbroadband.ie ([62.231.32.13]:47598 "EHLO
	smtp2.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S261243AbVGBRsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:48:01 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <chainsaw@gentoo.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120325613.5073.16.camel@mulgrave>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>  <1120325613.5073.16.camel@mulgrave>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yNyqSUa+lPYodlExjBVn"
Organization: Gentoo Linux
Date: Sat, 02 Jul 2005 18:47:03 +0100
Message-Id: <1120326423.22057.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yNyqSUa+lPYodlExjBVn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-07-02 at 13:33 -0400, James Bottomley wrote:
> There should be more debugging information after this as the device goes
> through domain validation, isn't there?

There is, but I have to write this out manually. I have only one PC
available. Got myself more paper and a better pen. Here it is:

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
scsi0: target 0 using asynchronous transfers
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
7
(scsi0:A:0:0): Received PPR bus_width 1, period 9, offset 7f,
ppr_options 7
Filtered to width 0, period 0, offset 0, options 0
 target0:0:0: asynchronous.
scsi0: target 0 using 8bit transfers
(scsi0:A:0:0): refuses tagged comands.  Performing non-tagged I/O
 target0:0:0: asynchronous
*PC hangs here*

> James=20
Tony.

--=-yNyqSUa+lPYodlExjBVn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCxtMXp5vW4rUFj5oRAl92AJ9REnCPJeBWbE6F4zRzVG418gWKdwCfbEPO
V73wUrzlPO+7dTsQSokbRVg=
=Qx+P
-----END PGP SIGNATURE-----

--=-yNyqSUa+lPYodlExjBVn--

