Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282300AbRLDCae>; Mon, 3 Dec 2001 21:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282858AbRLDC3F>; Mon, 3 Dec 2001 21:29:05 -0500
Received: from [213.22.99.56] ([213.22.99.56]:21642 "EHLO aeminium.aeminium.pt")
	by vger.kernel.org with ESMTP id <S282992AbRLDC2Y> convert rfc822-to-8bit;
	Mon, 3 Dec 2001 21:28:24 -0500
Date: Tue, 4 Dec 2001 02:28:07 +0000 (WET)
From: Nuno Miguel Fernandes Sucena Almeida <slug@aeminium.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 & ext2 kaboing ; iptables --list weirdness
Message-ID: <Pine.LNX.4.21.0112040208480.11754-100000@aeminium.aeminium.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello,

	i'm using a debian stable with 2.4.16 kernel , ext2 filesystem
with SMP support (but just one PIII cpu on a dual board), 512MB RAM, gcc
2.92.2 and after trying to compile perl (from testing) without success i  
started to make a rm -Rf and here's the result:

root@aeminium    02:11:43   Tue Dec  4
/usr/src/packages$rm -Rf perl-5.6.1 
rm: não consigo apagar `perl-5.6.1/t/big': Value too large for defined data type
rm: cannot remove directory `perl-5.6.1/t': Directory not empty
rm: cannot remove directory `perl-5.6.1': Directory not empty

root@aeminium    02:11:48   Tue Dec  4
/usr/src/packages$cd perl-5.6.1/t/    

root@aeminium    02:12:20   Tue Dec  4
/usr/src/packages/perl-5.6.1/t$ls
ls: big: Value too large for defined data type

my previous kernel was 2.4.13 (not .15 ;)

another curious fact:
iptables v1.2.2

iptables --list
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

although i have working NAT and Firewall rules.
i think i'm having also some UDP weirdness with a inet cablemodem
interface but got to check further...

					Nuno Sucena Almeida
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Para mais informações veja http://www.gnupg.org

iD8DBQE8DDTA8HEhaPSUrLkRAp0eAKDWJ/lbIqS4c3nwEczF7qEx/3s2egCgyQ2f
ChEaUps7EA2cZ9aBM2ZA4m0=
=IoiM
-----END PGP SIGNATURE-----

