Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131286AbRCMXcB>; Tue, 13 Mar 2001 18:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131287AbRCMXbw>; Tue, 13 Mar 2001 18:31:52 -0500
Received: from toscano.org ([64.50.191.142]:5343 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S131286AbRCMXbq>;
	Tue, 13 Mar 2001 18:31:46 -0500
Date: Tue, 13 Mar 2001 18:31:05 -0500
From: Pete Toscano <pete@toscano.org>
To: Juha Saarinen <juha@saarinen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
Message-ID: <20010313183105.H5626@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete@toscano.org>,
	Juha Saarinen <juha@saarinen.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010313092837.A805@wirex.com> <LNBBIBDBFFCDPLBLLLHFEEDEJGAA.juha@saarinen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <LNBBIBDBFFCDPLBLLLHFEEDEJGAA.juha@saarinen.org>; from juha@saarinen.org on Wed, Mar 14, 2001 at 08:25:37AM +1300
X-Unexpected: The Spanish Inquisition
X-Uptime: 6:28pm  up  9:31,  4 users,  load average: 0.04, 0.12, 0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Wed, 14 Mar 2001, Juha Saarinen wrote:

> Greg,
>=20
> :: It seems that the APIC on this motherboard does not have most of the
> :: pins connected, so that even if we could get the USB interrupt to work
> :: properly (which we couldn't) there would be no benefit to run in APIC
> :: mode.  I was going to run some crude benchmarks on the box with and
> :: without APIC mode just to get an sense if we are missing anything
> :: running in noapic mode, but I haven't gotten around to it yet.
>=20
> So for Tyan Tigers, is it better to compile the kernel without APIC? About
> to install Linux on a dual 500 P3 here.

AFAIK, the option to compile w/o APIC is only for UP systems.  If you
want to use both of your processors, you have to compile in APIC
support, but just disable it when loading the kernel (ie. for lilo,
'append=3D"noapic"')

> :: But, Linux does seem to run just fine with USB and SMP in the noapic
> :: mode, which is a lot better than Win2000 can say, as it doesn't even
> :: support the VIA USB chipset on this board at all :)
>=20
> There's a Win2K patch for VIA chip sets now... I've got USB working under
> Win2K here.

That would explain why it works for me.  Now, if only I didn't have
devices that need to have their BIOSes upgraded via a Windows .exe...

pete


--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6rq25sMikd2rK89sRAhkQAJ0Ss+QaCxMrRqT8t9BxQs1JhQJ87QCeJ2/G
EzmcQiEk/BQBLBTTOS9CLFI=
=JDHi
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
