Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVJLRpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVJLRpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJLRpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:45:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4274 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750808AbVJLRpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:45:12 -0400
Message-Id: <200510121745.j9CHj6XE023497@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Klaus Dittrich <kladit@arcor.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc* / xinetd 
In-Reply-To: Your message of "Wed, 12 Oct 2005 16:36:57 +0200."
             <20051012143657.GA1625@xeon2.local.here> 
From: Valdis.Kletnieks@vt.edu
References: <20051012143657.GA1625@xeon2.local.here>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1129139106_16609P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Oct 2005 13:45:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1129139106_16609P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 Oct 2005 16:36:57 +0200, Klaus Dittrich said:
> I noticed a huge cpu usage of xinetd with 2.6.14-rc4 
> starting with the first ntp request.

Umm.. why is xinetd listening for ntp requests at all?  I'm pretty sure that
xinetd fighting with xntpd for control of the socket isn't going to work nicely,
although I admit being mystified as to (a) why this ever worked for you and
(b) what specifically changed in -rc4 to cause the CPU spin.

What was the most recent kernel known to work, and what does the xinetd
config file entry for NTP look like?

--==_Exmh_1129139106_16609P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDTUuicC3lWbTT17ARAlUwAJ9hfWKXKT2zLu1pYG85Wk16mTC6ygCg2UP8
sVbmyD/rNMEidlJA1YKH68Q=
=x5hJ
-----END PGP SIGNATURE-----

--==_Exmh_1129139106_16609P--
