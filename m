Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUADQDF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUADQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:02:47 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:29714 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265729AbUADQCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:02:43 -0500
Subject: APM and ACPI sleep issues with 2.6
From: Ross Burton <ross@burtonini.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2FE/8gRcubEhhmA9pa9Q"
Message-Id: <1073232351.21389.111.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 16:05:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2FE/8gRcubEhhmA9pa9Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've just built 2.6.1-rc1-mm1, and am using it on my IBM ThinkPad X22.=20
However, it not won't sleep when I shut the lid.

With 2.4.22 (from debian sid's kernel package) APM works, and will
suspend-to-RAM when I shut the lid, and wake up again cleanly.  As that
worked well I never got around to configuring ACPI.

With 2.6.1-rc1-mm, when I shut the lid with APM enabled nothing
happens.  No messages on the console, nothing.

With ACPI and "echo 3 > /proc/bus/acpi/sleep" in the relevant acpid
file, shutting the lid results in at least a partial sleep, but it won't
resume.  The power button was also non-responsive at this point, and I
had to remove the battery to reboot.

So, what can I do to debug this problem?  APM not working is a
regression over 2.4.22, which is sad.

Thanks for any help,
Ross
(please CC: me, I'm not on this list)
--=20
Ross Burton                                 mail: ross@burtonini.com
                                          jabber: ross@burtonini.com
                                     www: http://www.burtonini.com./
 PGP Fingerprint: 1A21 F5B0 D8D0 CFE3 81D4 E25A 2D09 E447 D0B4 33DF


--=-2FE/8gRcubEhhmA9pa9Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+DnfLQnkR9C0M98RAr0sAJ9JMztzXowzt8LFtJSMST+TVlrjWACgrSiQ
0gdSFzR1xEudC3IajyQNanU=
=ZwKw
-----END PGP SIGNATURE-----

--=-2FE/8gRcubEhhmA9pa9Q--

