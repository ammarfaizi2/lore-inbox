Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbSI0SD5>; Fri, 27 Sep 2002 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSI0SD5>; Fri, 27 Sep 2002 14:03:57 -0400
Received: from hc652a8bf.dhcp.vt.edu ([198.82.168.191]:15232 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262537AbSI0SD4>; Fri, 27 Sep 2002 14:03:56 -0400
Message-Id: <200209271809.g8RI92e6002126@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38 
In-Reply-To: Your message of "Fri, 27 Sep 2002 17:55:10 BST."
             <20020927175510.B32207@infradead.org> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven>
            <20020927175510.B32207@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1145979100P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Sep 2002 14:09:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1145979100P
Content-Type: text/plain; charset=us-ascii

On Fri, 27 Sep 2002 17:55:10 BST, Christoph Hellwig said:

> And WTF is the use a security policy that checks module arguments?  Do
> you want to disallow options that are quotes from books on the index
> or not political correct enough for a US state agency?

How about a security policy that says:

1) Thou mayest do an 'modprobe wvlan_cs'

2) Thou mayest not do 'modprobe wvlan_cs eth=0'.

'eth=0' causes it to create the interface as 'wvlan0' 'wvlan1' etc rather
than 'eth0', 'eth1', etc.  This makes a difference if you have iptables
rules that say '-i eth+' or '-i wvlan+' that implement different rulesets
for wireless and hard-wired connections.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1145979100P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9lJ6+cC3lWbTT17ARAnL4AJ9Ki7Let8JvTDDw0V320JpqeCmTrQCgzYOd
rz8xa+xWV+8+8MHZrG8wqZ8=
=Vp0O
-----END PGP SIGNATURE-----

--==_Exmh_-1145979100P--
