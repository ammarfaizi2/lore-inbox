Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUDVQG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUDVQG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbUDVQFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:05:37 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:48273 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264291AbUDVQCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:02:53 -0400
Date: Thu, 22 Apr 2004 16:35:15 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alexander Hoogerhuis <alexh@boxed.no>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       cpufreq list <cpufreq@www.linux.org.uk>
Subject: Re: Speedstep on centrino
Message-ID: <20040422143515.GA21208@dominikbrodowski.de>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Alexander Hoogerhuis <alexh@boxed.no>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	cpufreq list <cpufreq@www.linux.org.uk>
References: <87n05aoxpa.fsf@dorker.boxed.no> <1082629118.5672.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1082629118.5672.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2004 at 08:18:38PM +1000, Jeremy Fitzhardinge wrote:
> On Sun, 2004-04-18 at 11:56, Alexander Hoogerhuis wrote:
> > Using SpeedStep for Centrino with decoding the speeds and voltages
> > (CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI) will not yield any output during
> > boot regarding cpufreq at all

This is normal; dmesg is kept clean if no error occurs -- in theory. Maybe
some errors do not result in printk()s yet, let's see...

> > and the battery useage is heavy. ACPI is enabled.=20

What does /proc/acpi/processor/./performance say, if it exists? and are
there files and proper values in /sys/devices/system/cpu/cpu0/cpufreq/ ?

	Dominik

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAh9gjZ8MDCHJbN8YRAiUYAJ9z5Wvqh2e2xa+3iwIxGJe+vu3ELwCeOg/z
ksgZusGnK9Fd2+U4ZNesKMg=
=6bTW
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
