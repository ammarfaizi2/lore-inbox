Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269784AbUJGKiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269784AbUJGKiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUJGKiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:38:14 -0400
Received: from lugor.de ([217.160.170.124]:15800 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S269784AbUJGKiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:38:09 -0400
From: Christian Hesse <christian.hesse@linuxob.de>
Organization: Linux Oberhausen
To: linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Date: Thu, 7 Oct 2004 12:37:56 +0200
User-Agent: KMail/1.7
Cc: Fraz <fraz@unimail.com.au>
References: <41650CAF.1040901@unimail.com.au>
In-Reply-To: <41650CAF.1040901@unimail.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2478670.6MZTo2TiZE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410071238.02326.christian.hesse@linuxob.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2478670.6MZTo2TiZE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 07 October 2004 11:30, Fraz wrote:
> I recently upgraded from linux 2.4.27 to 2.6.8.1 and noticed my laptop
> now makes a high pitch noise while idle. I traced it back to the
> processor module for acpi. 'rmmod processor' stops the noise.
>
> Using speed step to turn it down to 733 Mhz makes it a
> little quieter and doesn't change the tone.
>
> Is there any way to stop this? I googled around and found it had
> something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz
> in the 2.4 kernel. I couldn't find much else on this. Hunting around the
> code didn't help much, I don't know C.
>
> The laptop is a Compaq Evo N160 from Dec 2001. The reference in google
> was to a Centrino laptop with the same problem. I wrote to Dominik
> Brodowski who suggested posting here.

Take a look at this bug report:

http://bugme.osdl.org/show_bug.cgi?id=3D2478

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart2478670.6MZTo2TiZE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBZRyKlZfG2c8gdSURAn6SAKDKd1v7n1q+c9FFtNb2ci73tkzsAQCg/aQg
nhMrAmFpCrUHyyGzH4wWf7k=
=s00G
-----END PGP SIGNATURE-----

--nextPart2478670.6MZTo2TiZE--
