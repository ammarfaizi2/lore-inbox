Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVLXStO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVLXStO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 13:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLXStO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 13:49:14 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:45742 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S932228AbVLXStO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 13:49:14 -0500
Message-ID: <43AD981F.80202@feise.com>
Date: Sat, 24 Dec 2005 10:49:03 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051025 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: mouse issues in 2.6.15-rc5-mm series
References: <43ACEE14.7060507@feise.com> <200512241256.52189.dtor_core@ameritech.net>
In-Reply-To: <200512241256.52189.dtor_core@ameritech.net>
X-Enigmail-Version: 0.93.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig730924FC6852BF9222ED0390"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig730924FC6852BF9222ED0390
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Torokhov wrote on 12/24/05 09:56:

> On Saturday 24 December 2005 01:43, Joe Feise wrote:
>> [Note: please cc me on answers since I'm not subscribed to the kernel =
list]
>>
>> I am experiencing problems with mouse resyncing in the -mm series.
>> This is a Logitech wheel mouse connected through a KVM.
>> Symptom: whenever the mouse isn't moved for some seconds, it doesn't
>> react to movement for a second, and then resyncs. Sometimes, the
>> resyncing results in the mouse pointer jumping, which as far as I
>> know is a protocol mismatch.
>> While searching for reports of similar problems, I came across
>> Frank Sorenson's post from Nov. 23 (http://lkml.org/lkml/2005/11/23/53=
3).
>> Like in his case, reverting
>> input-attempt-to-re-synchronize-mouse-every-5-seconds.patch
>> resulted in a kernel without this problem.
>>
>=20
> Joe,
>=20
> Instead of reverting input-attempt-to-re-synchronize-mouse-every-5-seco=
nds
> patch could youplease drop the patch below on top of -mm.
>=20
> Jet me know if your mouse stays synchronized. Thanks!
>=20


Dmitry,

thanks, that patch works. The mouse stays synchronized.

-Joe



--------------enig730924FC6852BF9222ED0390
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFDrZgiKc8oZ1MoTeoRAmLZAKCyRIQEzpgatFcEifJ3w4XOgEpf9wCeIQuS
xfJln1lA4G5aXLWDnC9HeH4=
=4DRk
-----END PGP SIGNATURE-----

--------------enig730924FC6852BF9222ED0390--
