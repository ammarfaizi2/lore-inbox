Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUILNjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUILNjr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268722AbUILNjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:39:47 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:46599 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S268719AbUILNji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:39:38 -0400
Date: Sun, 12 Sep 2004 15:39:36 +0200
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
To: linux-kernel@vger.kernel.org
Subject: iMac G3 IPv6 issue
Message-ID: <20040912133936.GA11099@caladan.roxor.be>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

Since it is kernel related, I think it is the best place to ask.

I installed Debian Sid on a BlueBerry iMac G3.

[20:51:54|3|root@arwen:~]# cat /proc/cpuinfo
processor       : 0
cpu             : 740/750
temperature     : 52 C (uncalibrated)
clock           : 350MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 696.32
machine         : PowerMac2,1
motherboard     : PowerMac2,1 MacRISC Power Macintosh
detected as     : 66 (iMac FireWire)
pmac flags      : 00000005
L2 cache        : 512K unified
memory          : 128MB
pmac-generation : NewWorld

[20:54:17|3|root@arwen:~]# uname -a
Linux arwen 2.6.8.1 #1 Sat Aug 21 15:46:55 CEST 2004 ppc GNU/Linux

I put IPv6 support, but the console is flooded by a lot of:

printk: 16 messages suppressed.
hw tcp v6 csum failed
printk: 11 messages suppressed.
hw tcp v6 csum failed
printk: 5 messages suppressed.
hw tcp v6 csum failed
printk: 5 messages suppressed.
hw tcp v6 csum failed
printk: 5 messages suppressed.
hw tcp v6 csum failed
printk: 5 messages suppressed.
hw tcp v6 csum failed
printk: 7 messages suppressed.
hw tcp v6 csum failed

However, IPv6 works, and IPv4 packets do not have this kind of issue.

The network card is a Sun Gem. It is kind of weird to see bad packets.

Attached is my /proc/config.gz.

Is anyone aware of this issue?

Bests.
--=20
        _,met$$$$$gg.        Aur=E9lien G=C9R=D4ME
     ,g$$$$$$$$$$$$$$$P.     Free Software Developer
   ,g$$P""       """Y$$.".   Unix Sys & Net Admin
  ,$$P'              `$$$.
',$$P       ,ggs.     `$$b:  Web: https://www.roxor.be/
`d$$'     ,$P"'   .    $$$   Mail: ag@roxor.be
 $$P      d$'     ,    $$P   GPG Key ID: 03E1A172
 $$:      $$.   -    ,d$$'
 $$;      Y$b._   _,d$P'    ))  GNU  ((   /   Linux
 Y$$.    `.`"Y$$$$P"'      //         \\
 `$$b      "-.__          ((__,-"""-,__))     .---.
  `Y$$b                    `--)~   ~(--`     /     \
   `Y$$.      Debian      .-'(       )`-.    \.@-@./
     `$$b.                `~~`@)   (@`~~`    /`\_/`\
       `Y$$b.                 |     |       //  _  \\
         `"Y$b._              |     |      | \     )|_
             `""""            (8___8)     /`\_`>  <_/ \
                               `---`      \__/'---'\__/
BOFH excuse #423: It's not RFC-822 compliant.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRFGYkFH2kwPhoXIRAg/iAJ9mEmZnnG/e8wcTsSiL9tyOfgpBSQCfYE5U
9WCM5TkpjSfAQgunbQhws2Q=
=k/am
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
