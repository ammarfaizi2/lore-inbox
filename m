Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVEMQUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVEMQUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVEMQUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:20:14 -0400
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:18659
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S262420AbVEMQTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:19:46 -0400
Date: Fri, 13 May 2005 18:19:37 +0200
From: giskard <giskard@autistici.org>
To: luming.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: error on handling I/O ports
Message-ID: <20050513181937.471934b2@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.6cvs45 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Fri__13_May_2005_18_19_37_+0200_j3ilgoCZacTa+t6Q;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__13_May_2005_18_19_37_+0200_j3ilgoCZacTa+t6Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

>Could you just try acpi=3Doff ?

pcmcia seems work with acpi=3Doff but obviously battery and cpu scaling
are not supported. any hint?

On Monday 25 April 2005 22:09, giskard wrote:
> hi all,
>
> The 2.6.* kernel doesn't seems to handle properly the I/O ports for
> devices.
>
> I bought a toshiba satellite a80-111 and with 2.4 series all devices
> work good, with 2.6 series i get some errors:
>
> - the 2.4 kernel uses ide-generic (with sata support) for use the
>   hd, with 2.6 i need libata SATA support because i get this error
>
>   ide0: I/O resource 0x1F0-0x1F7 not free.
>   ide0: ports already in use, skipping probe
>
> - i have a 0000:06:04.0 CardBus bridge: Texas Instruments Texas
>   Instruments PCIxx21/ x515 Cardbus Controller
>
>   i can get it work with the 2.4 series with no problem (yenta
>   socket), the  2.6 series uses also yenta sockets but when i start
>   pcmcia service (/ etc/ init.d/pcmcia start) the kernel freezes when
> it checks the i/o ports.
>
>
> mrspurr:/usr/src/linux# uname -a
> Linux mrspurr 2.6.11.7 #12 Mon Apr 18 01:51:04 CEST 2005 i686 GNU/
> Linux
>
> i attached lspci -vvv log, iomem log, ioports log, cpuinfo log
>
> thank you in advance
--=20
ciao giskard

spero nel ritorno del grande bastardo.


--Signature_Fri__13_May_2005_18_19_37_+0200_j3ilgoCZacTa+t6Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFChNOZokwHIYS/ecgRAgunAJ0RcuR8feNONl5sL87UfYDOEMqBXgCePEHC
BdXyeOLaFp4Mu+M5v89n5CM=
=sQVW
-----END PGP SIGNATURE-----

--Signature_Fri__13_May_2005_18_19_37_+0200_j3ilgoCZacTa+t6Q--
