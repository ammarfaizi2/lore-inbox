Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbTGUU0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270724AbTGUU0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:26:14 -0400
Received: from main.gmane.org ([80.91.224.249]:39599 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270712AbTGUUZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:25:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Suspend on one machine, resume elsewhere
Date: Mon, 21 Jul 2003 13:41:33 -0700
Message-ID: <m2adb7bojm.fsf@tnuctip.rychter.com>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk>
 <20030716104026.GC138@elf.ucw.cz>
 <20030716195129.A9277@informatik.tu-chemnitz.de>
 <20030716181551.GD138@elf.ucw.cz> <m2r84m8jhh.fsf@tnuctip.rychter.com>
 <20030720225342.GA866@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:nb9VDtpEVu47B/ny/WCFMJ3smek=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Pavel" =3D=3D Pavel Machek <pavel@ucw.cz>:
 Pavel> Hi!
 > If you want to migrate programs between machines, run UMLinux, same
 > config, on both machines. Ouch and you'll need swsusp for UMLinux,
 > too
 >
 > That might be more important than you think.
 >>
 Pavel> :-). Well, it is also harder than you probably think, because
 Pavel> UML is *very* strange architecture and it is not at all easy to
 Pavel> save/restore its state. There were some patches in that area,
 Pavel> but it never worked (AFAIK).
 >>
 >> ... but there are many people who dream about swsusp for UMLinux.
 >>
 >> Particularly some laptop users who want to suspend (at least the
 >> most critical long-running applications) and/or find Linux way too
 >> unstable and requiring frequent reboots.
 >>
 >> The day UMLinux gets swsusp, I'm moving my XEmacs, mozilla and some
 >> other toys into a UML machine and staying there. Hopefully then a
 >> single problem with a USB driver, keventd running wild, or other
 >> frequently encountered breakage won't be taking my entire world
 >> down.

 Pavel> Well, then you may as well help porting swsusp to UML ;-).

 Pavel> OTOH, single problem with suspend *will* then bring your entire
 Pavel> world down :-(. You would be able to rollback, through.=20=20

But that's significantly better than any USB problem or any ALSA problem
or any ACPI problem bringing down my entire world, which is the current
situation with Linux 2.4.

I have the impression that the core developers are unaware of the fact
of how unstable Linux has become, particularly on laptops. I guess if
you do kernel work and reboot often, you never notice that. Besides,
doing stability work is "unfashionable"...

=2D-J. (duly trying to report all bugs encountered)

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HFAFLth4/7/QhDoRAhbaAJ4pe648h5EpmX8BciZJOo4c78YGNACdGQ5G
IvblLsZJrJvURQjutZsqm64=
=lM2O
-----END PGP SIGNATURE-----
--=-=-=--

