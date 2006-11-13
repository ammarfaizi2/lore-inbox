Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbWKMTN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWKMTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWKMTN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:13:56 -0500
Received: from ms-smtp-05.ohiordc.rr.com ([65.24.5.139]:16325 "EHLO
	ms-smtp-05.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S932795AbWKMTNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:13:55 -0500
Date: Mon, 13 Nov 2006 14:12:05 -0500
To: Julien BLACHE <jb@jblache.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: Intel RNG: firmware hub changes in 2.6.19 break 82802 detection on Core2 Duo MacBook Pro
Message-ID: <20061113191205.GA15349@nineveh.rivenstone.net>
Mail-Followup-To: Julien BLACHE <jb@jblache.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <87u015osxb.fsf@frigate.technologeek.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <87u015osxb.fsf@frigate.technologeek.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: jhf@columbus.rr.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 12, 2006 at 11:33:52AM +0100, Julien BLACHE wrote:
> Hi,
>
> On a new Core2 Duo MacBook Pro, 2.6.19-rc5 fails to detect the 82802
> RNG with this message:
>
>  intel_rng: FWH not detected
>
> Though it worked in 2.6.18:
>
>  Intel 82802 RNG detected
>
>
> This is an x86_64 kernel booted via good old lilo, so using the
> BootCamp BIOS emulation provided by Apple.

    The intel_rng driver recently changed the way it detected the RNG,
because it got a lot of false positives.

    I have the older Core Duo MacBook, and there is no RNG here,
though it used to be detected.  rngd would disable it immediately when
I tried to use it.

--
Joseph Fannin
jfannin@gmail.com || jhf@columbus.rr.com


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFFWMOE1/BPLCVlRuARAm/FAKCBkEx9f6I87P+vha32jxvVZvPWggCgxVn0
pJ+EYphI+Ui3w+HpoMoW+Ic=
=K+/P
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
