Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132322AbQLVWnl>; Fri, 22 Dec 2000 17:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132411AbQLVWnc>; Fri, 22 Dec 2000 17:43:32 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:14465 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S132322AbQLVWnV>; Fri, 22 Dec 2000 17:43:21 -0500
Date: Fri, 22 Dec 2000 17:12:50 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: please help: usb and irq problem with 2.2.18 and 2.4.0-test?
Message-ID: <20001222171250.A28612@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 2:26pm  up 2 days, 20:03,  4 users,  load average: 0.21, 0.17, 0.16
X-Married: 404 days, 18 hours, 41 minutes, and 29 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i've asked a few times, both off-list and on and nobody seems to be able
to help.

quite a few people are seeing usb fail (with the "device not accepting
new address" error messages) on the 2.2.18 and 2.4.0-testX kernels with
smp enabled when using a mobo with the apollo pro 133a chipset.  when
apic is disabled, everything works, but with it enabled, it seems that
the usb driver (usb-uhci) is not getting any interrupts.  johannes
erdfelt thinks that it's a pci irq routing problem (/proc/interrupts is
showing no interrupts for usb-uhci when apic is enabled) and suggested
talking with the pci irq people.

i eager to help debug this problem and apply any and all test patches to
find fixes.  i am pretty sure that greg k-h (greg AT kroah DOT com) is
also willing to do the same.  the problem is, we can't get any pci irq
people to look into this.  is this a problem with the pci irq routing?
is this a known problem that someone's working on?  is it just not worth
the effort?  there are already quite a few people on the linux-usb list
who are seeing this problem.  i'm sure that when 2.4.0 comes out, a lot
more people will be seeing this problem too.  please, let's try to stomp
this out before 2.4.0 and make linux look just that little bit more
shiny.  =3D8] =20

(sorry for that bit of a rant, but i'm getting just a little bit
frustrated with this long-standing problem.)

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Q9HiH/Abp5AIJzYRAopDAJ9LcrPY0f8dUToVnXv5ypam1NOOZgCgtd+1
tbex476NxGbxBYIHITbtR4Q=
=whY0
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
