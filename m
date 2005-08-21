Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVHUVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVHUVlv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVHUVlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:41:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:42445 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751162AbVHUVlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:41:49 -0400
From: "Hesse, Christian" <mail@earthworm.de>
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: IRQ problem with PCMCIA
Date: Sun, 21 Aug 2005 20:43:50 +0200
User-Agent: KMail/1.8.2
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)k
	:nv*xqk4C@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)n#Q.o
	kE~&T]0cQX6]<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<3O7GY9y_i!qG&Vv\D8/
	%4@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6434333.k1MGe9Z7Nz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508212043.58331.mail@earthworm.de>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6434333.k1MGe9Z7Nz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello everybody,

seems like I have a problem with PCMCIA/PCCARD. If I transfer data to or fr=
om=20
a CF card inserted via adapter system waits for interrupts most of the time:

Cpu(s): 21.2% us,  7.9% sy,  0.0% ni,  0.0% id,  1.7% wa, 69.2% hi,  0.0% si

This results in a very unresponsive system and a transfer rate of up to 1MB=
/s=20
(my new camera writes with up to 10MB/s on the card...).

Any idea what could be the reason? This is with 2.6.12/pcmcia-cs and with=20
2.6.13-rc*/pcmciautils. The CF card is a Lexar 1GB.

root@logo:~# cat /proc/interrupts | grep yenta
 11:    5914154          XT-PIC  yenta, yenta, uhci_hcd:usb2, Intel=20
82801DB-ICH4, ide2

=2D-=20
Regards,
Christian

--nextPart6434333.k1MGe9Z7Nz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.18 (GNU/Linux)

iD8DBQBDCMttlZfG2c8gdSURAkjIAKD37Ww3Xxu5PKv38xE9nUnaZAIpQgCfVAD5
B73Nx3ex3q5sddZZcKVY1o4=
=/7aC
-----END PGP SIGNATURE-----

--nextPart6434333.k1MGe9Z7Nz--
