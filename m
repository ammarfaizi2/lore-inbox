Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbWBPTuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWBPTuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWBPTuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:50:52 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:49850 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S1030584AbWBPTuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:50:51 -0500
Date: Thu, 16 Feb 2006 20:49:56 +0100
To: opensuse-factory@opensuse.org
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, kkeil@suse.de,
       linux-kernel@vger.kernel.org, libusb-devel@lists.sourceforge.net
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060216194955.GM3595@schiele.dyndns.org>
Mail-Followup-To: Robert Schiele <rschiele@uni-mannheim.de>,
	opensuse-factory@opensuse.org, Greg KH <greg@kroah.com>,
	torvalds@osdl.org, kkeil@suse.de, linux-kernel@vger.kernel.org,
	libusb-devel@lists.sourceforge.net
References: <20060205205313.GA9188@kroah.com> <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YS7t75H5cNTCpbja"
Content-Disposition: inline
In-Reply-To: <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
User-Agent: Mutt/1.5.9i
From: Robert Schiele <rschiele@uni-mannheim.de>
Reply-To: Robert Schiele <rschiele@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YS7t75H5cNTCpbja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2006 at 03:24:44PM +0100, Sven Schmidt wrote:
> The user space does not ensure the reliability of time critical analog
> services like Fax G3 or analog modem emulations. This quality of service
> can only be guaranteed within the kernel space.

Huh? You are offering your fax emulation at
ftp://ftp.avm.de/fritz.box/tools/fax4box/ for Windows to communicate over
Ethernet with the Fritz!Box.  You don't tell me that communicating over
Ethernet is more reliable than implementing it in user space?  Or is my
understanding about how this tool is working completely wrong?

> As a private corporation our primary focus is market relevance. AVM
> invested more than 10 years of work to make analog services like Fax G3 a=
nd
> analog modem emulation available to users of the digital ISDN network. The
> situation is similar for the DSL part of the driver with very complex DSP
> algorithms. To anticipate any "open vs. closed source" discussion:Only a
> handful of companies worldwide have such know-how. With regard to our
> competitive situation, we have to protect our hard-won intellectual
> property and therefore cannot open the closed source part of the driver.

It is perfectly understandable that you don't want to offer this special
know-how in public.  But isn't your implementation modular enough to open
source the drivers _without_ support for these analog services as a first
step?  This driver could then be shipped without problems enabling your use=
rs
to download a more advanced closed source module from your web site if desi=
red
and you don't care about the license issues.

Robert

--=20
Robert Schiele			Tel.: +49-621-181-2214
Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de

"Quidquid latine dictum sit, altum sonatur."

--YS7t75H5cNTCpbja
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFD9NdjxcDFxyGNGNcRAtZ1AKC7wMK0N6rUmfNvTGPI96g3ayHNqwCfYCBv
ZzQGkhrM/7CcjVrNcm58Sjk=
=AwgG
-----END PGP SIGNATURE-----

--YS7t75H5cNTCpbja--

