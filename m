Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTDQTxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTDQTxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:53:41 -0400
Received: from ip-a1-37024.keycomm.it ([62.152.37.24]:22604 "HELO
	sparc.campana.vi.it") by vger.kernel.org with SMTP id S261977AbTDQTxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:53:39 -0400
Date: Thu, 17 Apr 2003 22:05:06 +0200
From: Ottavio Campana <ottavio@campana.vi.it>
To: linux-kernel@vger.kernel.org
Subject: noapic and usb, linux 2.4.20
Message-ID: <20030417200506.GA20466@campana.vi.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux dirac 2.4.20-dirac2 
X-Organization: Lega per la soppressione del Visual Basic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm trying to  have usb working on my  pc, based on a dual  athlon and a
motherboard GA-7DPXDW with linux 2.4.20 with  the patch for xfs from sgi
and the patch for the sensors.

I was reading the linux-usb faq and I found:=20
> Sometimes a  BIOS fix will be  available for your motherboard,  and in
> other cases  a more recent  kernel will have a  Linux fix. You  may be
> able to  work around this  by passing the  noapic boot option  to your
> kernel,  or (when  you're using  an add-in  PCI card)  moving the  USB
> adapter to some  other PCI slot. If you're using  a current kernel and
> BIOS,  report this  problem  to the  Linux-kernel  mailing list,  with
> details about your motherboard and BIOS.

So I'm  writing hoping  to be  helpful. Usb  works, but  I have  to pass
noapic to  the kernel.  Otherwise I get  "device not  accepting address"
when I plug a device in the usb port. The motherboard has been bought in
september. I remember the older mobos  had the southbridge b1, which had
a faulty usb. My mobo has got the southbridge b2, which works.

Is there anything useful I can do?

Can you please explain me what "noapic" does? I think it changes the way
interrupts are  handled, but I'm  not sure. Do  I miss something  when I
pass noapic to the kernel?

Bye

PS: can you please cc your answer to my mailbox? Thank you.

--=20
Non c'=E8 pi=F9 forza nella normalit=E0, c'=E8 solo monotonia.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Per informazioni si veda http://www.gnupg.org

iD8DBQE+nwjyTVwmA6p94JARAk0wAJoCv7W/szBRilvUBnSeN7lXgD3dAgCfeRXq
GcRJjOB8sI+cgwCAUnapguk=
=n4Kl
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
