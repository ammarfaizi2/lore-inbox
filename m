Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270656AbTG0DNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 23:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270657AbTG0DNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 23:13:05 -0400
Received: from h80ad2442.async.vt.edu ([128.173.36.66]:4246 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270656AbTG0DND (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 23:13:03 -0400
Message-Id: <200307270328.h6R3S3Kp014744@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3) 
In-Reply-To: Your message of "Sat, 26 Jul 2003 17:21:37 +0200."
             <1059232897.10692.37.camel@sonja> 
From: Valdis.Kletnieks@vt.edu
References: <3F1EF7DB.2010805@namesys.com> <1059062380.29238.260.camel@sonja> <16160.4704.102110.352311@laputa.namesys.com> <1059093594.29239.314.camel@sonja> <16161.10863.793737.229170@laputa.namesys.com> <1059142851.6962.18.camel@sonja> <1059143985.19594.3.camel@haron.namesys.com> <1059181687.10059.5.camel@sonja> <1059203990.21910.13.camel@haron.namesys.com> <1059228808.10692.7.camel@sonja> <1059231274.28094.40.camel@haron.namesys.com>
            <1059232897.10692.37.camel@sonja>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-929320262P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 26 Jul 2003 23:28:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-929320262P
Content-Type: text/plain; charset=us-ascii

On Sat, 26 Jul 2003 17:21:37 +0200, Daniel Egger said:
> > Also reiserfs does not use compression, that would be very nice of it
> > :), because flash has limited number of erase cycles per block (in range
> > 100.000)
> 
> I don't see what the compression has to do with the limited number of
> erase/write cycles.

It's a subtle point - let's say you have a 32K blob of data and a 4K block/
erase/whatever size on the flash.   If you write it uncompressed, then 8 blocks
are going to get an erase cycle.  If however you can compress it down to 12K
(not at all unusual for text), then only 3 blocks get an erase cycle, and the
other 5 blocks get to live longer...


--==_Exmh_-929320262P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/I0bCcC3lWbTT17ARArFDAJ9dqeOaejZZy7frPv7+6jNuoYxtmgCg7joF
D6YzmxWxs248eghz6dpj6Bo=
=+P9G
-----END PGP SIGNATURE-----

--==_Exmh_-929320262P--
