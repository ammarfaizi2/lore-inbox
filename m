Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTJQTlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJQTlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:41:47 -0400
Received: from main.gmane.org ([80.91.224.249]:13214 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263600AbTJQTlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:41:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: [PATCH] laptop mode
Date: Fri, 17 Oct 2003 12:42:13 -0700
Message-ID: <m2ekxb7isq.fsf@tnuctip.rychter.com>
References: <3F856A7E.2010607@pobox.com> <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet>
 <20031009141143.GF1232@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:jq/3wCI0GY1Ntx6Oej9cZSWdFR8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Jens" =3D=3D Jens Axboe <axboe@suse.de> writes:
 Jens> On Thu, Oct 09 2003, Marcelo Tosatti wrote:
 >> On Thu, 9 Oct 2003, Jeff Garzik wrote:
 > Linux Kernel Mailing List wrote:
 > > ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
 > > 	[PATCH] laptop mode
 > >
 > > 	Hi Marcelo,
 > >
 > > 	Lots of people have been using this patch with great success,
 > > 	and it's been in the SuSE kernel for some months now too. It is
 > > 	also in the -benh ppc tree
 > >
 > > 	Basically, it introduces a write back mode of dirty and journal
 > > 	data that is more suitable for laptops. At the block layer end,
 > > 	it schedules write out of dirty data after the disk has been
 > > 	idle for 5 seconds.
 > >
 > > 	Laptop mode can be switched on and off with
 > > 	/proc/sys/vm/laptop_mode.  There is also a block_dump sysctl,
 > > 	which if enabled will dump who dirties and writes out data. This
 > > 	is very helpful in pinning down who is causing unnecessary
 > > 	writes to the disk.
 >
 > Red Hat just dropped this patch since it was suspected of data
 > corruption ;-(
 >>
 >> Uh, oh... Jens?

 Jens> See my previous mail. I don't see any problems with it, and I've
 Jens> certainly not heard of (or experienced myself) problems with the
 Jens> patch.  I'm waiting for Jeff to expand on his mail, surely he/RH
 Jens> must know more about this issue.

FWIW, I've been using laptop-mode for a long time now, with no problems
whatsoever. It's a great addition and really helps laptop users.

On a related note, a very desirable feature would be to be able to trace
which processes do I/O. Unfortunately, Linux distributions aren't very
well adapted to laptops and many applications are way too
"trigger-happy" when it comes to hard drive accesses. I guess most
developers don't use laptops and just assume that they can write or
read data at will. It is very difficult to trace the culprits when your
HD light goes on every couple of seconds.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/kEYWLth4/7/QhDoRAj3+AJ90dZ6MYPbXap1jdGlKFACYjf0D/ACdHIYy
2ltpUTFKSzaIzXJ9xhKBI+k=
=VC5n
-----END PGP SIGNATURE-----
--=-=-=--

