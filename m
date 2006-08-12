Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWHLNOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWHLNOD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 09:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWHLNOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 09:14:02 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:15260 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932505AbWHLNN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 09:13:56 -0400
X-Sasl-enc: PVfwppdPU2hFlpBtOBCgrXQXAlUYI91kNh0+eealL5R/ 1155388434
Message-ID: <44DDD432.8030302@imap.cc>
Date: Sat, 12 Aug 2006 15:14:26 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1: printk delays
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9605.6000601@imap.cc>	 <1152229599.24656.175.camel@cog.beaverton.ibm.com>	 <44ADA84A.9000603@imap.cc> <1152233897.24656.179.camel@cog.beaverton.ibm.com>
In-Reply-To: <1152233897.24656.179.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1D15D68CADEEEAAC7754B0B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D15D68CADEEEAAC7754B0B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 07 Jul 2006 17:06:09 +0200, john stultz wrote:
> Hmmm. Just to make sure I understand the situation: If you log in via
> ssh, and run dmesg, you do see your driver's output, but that output
> just doesn't get to syslog until you press a key on your keyboard?

Exactly. And it's only the system keyboard which does it - neither mouse
movements nor network traffic (like hitting keys in the ssh session) or
other system activity (like compiling the kernel of the day) will do.

FYI, the issue is still present in 2.6.18-rc4 and 2.6.18-rc3-mm2.

Please let me know if you need more information or if you want me to
test something.

Thanks,
Tilman

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig1D15D68CADEEEAAC7754B0B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE3dQ6MdB4Whm86/kRAmT2AJ9HTOrVosfAU+jvGR5L9xaaKcXUnQCcCPU/
q+NaMhgpulc3CAwrvniv0IE=
=e/yE
-----END PGP SIGNATURE-----

--------------enig1D15D68CADEEEAAC7754B0B8--
