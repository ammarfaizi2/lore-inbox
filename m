Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUANPKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUANPKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:10:21 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:5579 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261563AbUANPKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:10:16 -0500
Date: Wed, 14 Jan 2004 16:08:06 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: paul.devriendt@amd.com
Cc: pavel@ucw.cz, davej@redhat.com, mark.langsdorf@amd.com,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114150806.GA5137@dominikbrodowski.de>
Mail-Followup-To: paul.devriendt@amd.com, pavel@ucw.cz,
	davej@redhat.com, mark.langsdorf@amd.com, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C080EF3A4@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF3A4@txexmtae.amd.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2004 at 08:49:18AM -0600, paul.devriendt@amd.com wrote:
> Absolutely. I am planning on using them also in the new ACPI based driver,
> along with your acpi-perflib.

Excellent.

> What is your progress on getting acpi-perflib merged into the kernel so t=
hat
> an additional patch is not needed ?

Unfortunately, it seems to be too invasive in the form it was proposed at
first. However, I'm currently in the process of getting the same
infrastructure[*] in place by doing small, logical, incremental changes to
drivers/acpi/processor.c. The first three patches are submitted to Len Brown
[1][2][3]; I haven't received a reply from him about these patches yet.

What helps in developing this is that I finally own a notebook
which supports ACPI P-States....

	Dominik

[*] or almost the same infrastructure. The first two core patches assure=20
that
_PPC and passive cooling work.

[1] http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D107398569012495&w=3D2
[2] http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D107398568612489&w=3D2
[3] http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D107407671712989&w=3D2

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABVtWZ8MDCHJbN8YRAkM/AJ47tbig09FYxsmGPJeGoZNaZP0zCACfUH6l
kSr94kLj65/nm9+YA3dIzDY=
=4Wls
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
