Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUCNQml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUCNQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 11:42:41 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:197 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261432AbUCNQmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 11:42:37 -0500
Date: Sun, 14 Mar 2004 17:32:56 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Pavel Machek <pavel@suse.cz>
Cc: patches@x86-64.org, kernel list <linux-kernel@vger.kernel.org>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>, davej@redhat.com,
       paul.devriendt@amd.com
Subject: Re: powernow-k8 updates
Message-ID: <20040314163256.GA24433@dominikbrodowski.de>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, patches@x86-64.org,
	kernel list <linux-kernel@vger.kernel.org>,
	Cpufreq mailing list <cpufreq@www.linux.org.uk>, davej@redhat.com,
	paul.devriendt@amd.com
References: <20040309214830.GA1240@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20040309214830.GA1240@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2004 at 01:07:20PM +0100, Pavel Machek wrote:
> [Is it okay to post it to the lists for more testing and/or
> inclusion?]
                                                                           =
    =20
I prefer patches to files to comment on.
                                                                           =
    =20
> +config X86_POWERNOW_K8_ACPI
> +     tristate "AMD Opteron/Athlon64 PowerNow! using ACPI"
> +     depends on CPU_FREQ && EXPERIMENTAL
depends on ... && ACPI ?
                                                                           =
    =20
See also the other mail discussing how to handle the two methods to detect
speed.
                                                                           =
    =20
Unfortunately, I consider this new ACPI driver to be in an "unmergeable"
state, as the extra "polling" is unneccessary if the ACPI perflib is used,
the extra parsing of ACPI tables can fail much too easily, and the whole
driver is too fragile with regard to ACPI interaction.

	Dominik

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVIk4Z8MDCHJbN8YRAky1AKCQ6eb8DsX+qb7B4pdIsVTMVrBgXACgjylG
CssNp956xVtZuNtt+UFts1M=
=szQp
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
