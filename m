Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTHGQ56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270443AbTHGQ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:57:57 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:38383 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270439AbTHGQ5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:57:55 -0400
Subject: Re: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Kathy Frazier <kfrazier@mdc-dayton.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
References: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tVgVwPzUzdHVMCj82Eo0"
Organization: Red Hat, Inc.
Message-Id: <1060275464.5142.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-2) 
Date: Thu, 07 Aug 2003 18:57:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tVgVwPzUzdHVMCj82Eo0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-08-07 at 18:08, Kathy Frazier wrote:
> I am experiencing problems with the CPU idle call feature on an ASUS P4PE
> (Intel 82845PE MCH and Intel 82801DB ICH4 chipsets).  I am using kernel
> 2.4.20-8 (Red Hat 9.0).=20

that's an old kernel.. several updates have followed since... several
machines have been added to the apm idle blacklist in later kernels
>
>  We were having trouble with our system "hanging"
> after running for a while.    By this I mean, that no IRQs are getting
> through, but software components are still running.  We have a proprietar=
y
> PCI DMA bus master device that works fine in PIII system, but the plans a=
re
> to ship our product using this ASUS MoBo.  In the process of trying to de=
bug
> this problem, we have updated BIOS, tweaked BIOS parameters, added debug =
to
> the kernel to determine the status of our IRQ, etc.  When I changed the
> CONFIG_APM_CPU_IDLE to no, our 3 hour test runs to completion.  Previousl=
y
> this test would cause the system to hang within minutes.  I have tried
> various combinations of APM tweaking with the following results:

if you can mail the top part of the dmidecode output (the part that has
the bios idents) the machine can trivially be added to the apm idle
blacklist.


--=-tVgVwPzUzdHVMCj82Eo0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MoUIxULwo51rQBIRAht9AJ9DCcWMT35STv1KpjupXUoO0YO48wCdEu75
2UxCXojO6IJbaXwCVKBvytk=
=S4Sc
-----END PGP SIGNATURE-----

--=-tVgVwPzUzdHVMCj82Eo0--
