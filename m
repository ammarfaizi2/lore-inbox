Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVAKJUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVAKJUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVAKJUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:20:45 -0500
Received: from h80ad2572.async.vt.edu ([128.173.37.114]:29456 "EHLO
	h80ad2572.async.vt.edu") by vger.kernel.org with ESMTP
	id S262643AbVAKJU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:20:29 -0500
Message-Id: <200501110920.j0B9JwAL006980@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp 
In-Reply-To: Your message of "Mon, 10 Jan 2005 23:42:30 PST."
             <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com> <20050111035810.GG14239@krispykreme.ozlabs.ibm.com>
            <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105435195_27063P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jan 2005 04:19:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105435195_27063P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jan 2005 23:42:30 PST, Joel Jaeggli said:

> In actually using sfs97r1 published benchmarks to compare to hardware I 
> was benchmarking (from emc, netapp and several roll-your own linux boxes) 
> I found the published benchmark information alsmost entirely useless given 
> that vendors tend to provide wildly silly hardware configurations. In the 
> case of the openpower 720 (to use that for an example) the benchmarked 
> machine has 70 15k rpm disks spread across 12 fibre channel controllers, 
> 64GB of ram, 12GB of nvram and 7 network interfaces...

If you threw that much hardware at a Linux system, and then tuned it so that it
didn't really care about userspace performance (oh.. say.. by giving the knfsd
thread a RT priority ;), and tuned things like the filesystem, the slab
allocator and the networking stack to NFS requirements, it probably would be
screaming fast too.. ;)


--==_Exmh_1105435195_27063P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB45o7cC3lWbTT17ARAj9LAJ9cNo/eoNx1qgtirkJ1sLpU3eyWMQCgrrD9
2haUKS82M2dgbjQew0sc2II=
=Oh23
-----END PGP SIGNATURE-----

--==_Exmh_1105435195_27063P--
