Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTIZT4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 15:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTIZT4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 15:56:15 -0400
Received: from main.gmane.org ([80.91.224.249]:25519 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261615AbTIZT4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 15:56:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: vmware in Linux 2.6
Date: Fri, 26 Sep 2003 12:56:10 -0700
Message-ID: <m2oex79vdx.fsf@tnuctip.rychter.com>
References: <14D30F86678@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:2Rc15aEgwkwm6gz/tEOPXwYqibA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Petr" =3D=3D Petr Vandrovec <VANDROVE@vc.cvut.cz>:
 Petr> On 26 Sep 03 at 12:50, Mons Rullgord wrote:
 >> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
 >>
 > Is it possible to use vmware with Linux 2.6?  The kernel modules
 > (obviously) fail to compile.

[...]

 Petr> And except that this patch makes thing compilable, it also makes
 Petr> driver a bit friendlier to the MM subsystem, it allows you to use
 Petr> VMware on 4G/4G host, and it properly handles bridged networking
 Petr> on adapters using hardware (or pseudohardware...) Tx checksumming
 Petr> (although only for IPv4 due to features of dev_queue_xmit_nit).

Does VMware roll these changes back in? This isn't cheap software, I
feel they should care for Linux users a bit more.

For those who run VMware on notebooks with ACPI, another patch is
necessary, otherwise ACPI C-states handling doesn't notice VMware and as
a result the guest system is unbearably slow.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dJnbLth4/7/QhDoRAgi+AKC2DPxUjGQqyJRAIylfeRc1DNpf8wCg37h8
OvpI2az6uzAxU7AHkyxj0Dg=
=V0hO
-----END PGP SIGNATURE-----
--=-=-=--

