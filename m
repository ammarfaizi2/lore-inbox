Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVJOW7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVJOW7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVJOW7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:59:53 -0400
Received: from smtp04.auna.com ([62.81.186.14]:10916 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1751258AbVJOW7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:59:52 -0400
Date: Sun, 16 Oct 2005 01:01:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: hdparm almost burned my SATA disk
Message-ID: <20051016010153.768d29d5@werewolf.able.es>
X-Mailer: Sylpheed-Claws 1.9.15cvs48 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Sun__16_Oct_2005_01_01_53_+0200_sLENwLNs8F8XzyEu;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.217.219] Login:jamagallon@able.es Fecha:Sun, 16 Oct 2005 00:59:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Sun__16_Oct_2005_01_01_53_+0200_sLENwLNs8F8XzyEu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all...

I have seen a very strange thing.=20
I was trying hdparm -tT on a SATA disk, it did the buffered part OK,
and hanged my box in the non-buffered measure. After waiting some minutes,
I did a SysRQ-s-u-b, and the the disk began to give many read errors on
sectors and could not boot because journal was not present and many other
errors.

After some warm and cold boots, finally the box came up correctly.
I suspect that something that hdparm did left my disk dumb. But what ?
I will keep away from hdparm for some time...

Any idea ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.13-jam8 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Signature_Sun__16_Oct_2005_01_01_53_+0200_sLENwLNs8F8XzyEu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDUYphRlIHNEGnKMMRAgb7AKCK4iCPaEy5UiMINddh3MyUAiOHrwCfQhX+
+7IHFD+Th6d+cK9kiTPLIzY=
=gZ30
-----END PGP SIGNATURE-----

--Signature_Sun__16_Oct_2005_01_01_53_+0200_sLENwLNs8F8XzyEu--
