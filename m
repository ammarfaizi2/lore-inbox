Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265197AbUEUXiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265197AbUEUXiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUEUXgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:36:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:55731 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265060AbUEUXTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:19:32 -0400
Date: Thu, 20 May 2004 20:02:55 -0700
From: Bob McElrath <bob@mcelrath.org>
To: sziwan@hell.org.pl, mru@kth.se, linux-kernel@vger.kernel.org
Subject: ACPI interrupts on Asus
Message-ID: <20040521030255.GA16390@mcelrath.org>
Mail-Followup-To: sziwan@hell.org.pl, mru@kth.se,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You both indicated on the LKML list that you have an ASUS laptop and
after a suspend, ACPI interrupts are not received.  It seems no
resolution to this is posted on the LKML list.  Have either of you
figured out how to fix this?

I have an L3800C and have gotten S1 and S3 sleep working, but for both
after resuming, acpi interrupts are no longer processed.  (no more
interrupts in /proc/interrupts)  I have tried various combinations of:
    acpi=3Dnoirq
    pci=3Dnoacpi
    acpi_irq_balance
    pci=3Dusepirqmask
and this always happens, regardless of whether the acpi interrupt is
shared.

Thanks,
Bob McElrath [Univ. of California at Davis, Department of Physics]
   =20
    "A great many people think they are thinking when they are merely
    rearranging their prejudices." -- William James


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArXFfjwioWRGe9K0RArUXAJwIi2a3Pzi3gx22ii+eLGf7QC99owCg2UFI
ejtkdHC1POsu2fNtXqPw3fM=
=8sV5
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
