Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTHaHwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 03:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbTHaHwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 03:52:15 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:65161 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261909AbTHaHwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 03:52:13 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Claas Langbehn <claas@rootdir.de>
Subject: Re: 2.6.0-test4 acpi problems
Date: Sun, 31 Aug 2003 09:52:03 +0200
User-Agent: KMail/1.5.9
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20030830203353.GA967@rootdir.de>
In-Reply-To: <20030830203353.GA967@rootdir.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_pkaU/H0c7lb2jjk";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308310952.09713.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_pkaU/H0c7lb2jjk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 30 August 2003 22:33, Claas Langbehn wrote:
> Hello!

Hi Claas!

> I have got an Epox 8K9A9i mainboard with an Athlon XP 1800+ CPU. The
> chipset is an VIA KT400A. The bios is dated 12.05.2003.
> When booting with ACPI enabled, the interrupts dont get enumerated
> properly. with acpi=3Dht it works, but i dont have enough features.
> Below you see my bootlog with acpi and further down the bootlog with
> acpi=3Doff. Is there a way to use full acpi support and "normal"
> interrupts? pci=3Dnoacpi was not really successful.

My noacpi-option-fix should solve the pci=3Dnoacpi issue. It is available a=
t:
	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-
test4/2.6.0-test4-mm2/broken-out/noacpi-option-fix.patch

Alternatively you may run 2.6.0-test4-mm2 or -mm3 as these include the patc=
h=20
(and many other things)...

> How can I help acip development and do more debugging?
>
>
> Regards, claas

   Thomas

--Boundary-02=_pkaU/H0c7lb2jjk
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/UakpYAiN+WRIZzQRArzOAJsGLa/xKmaDnB1hrQoPasQANpesMQCeJas+
zpI0Lju6imWewAyAFMx56rs=
=iFiM
-----END PGP SIGNATURE-----

--Boundary-02=_pkaU/H0c7lb2jjk--
