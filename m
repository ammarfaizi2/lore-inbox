Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVADXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVADXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVADXMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:12:05 -0500
Received: from grendel.firewall.com ([66.28.58.176]:5004 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262155AbVADXJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:09:11 -0500
Date: Wed, 5 Jan 2005 00:09:10 +0100
From: Marek Habersack <grendel@caudium.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050104230910.GF5592@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050104195636.GA23034@beowulf.thanes.org> <20050104220521.GE7048@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20050104220521.GE7048@alpha.home.local>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 04, 2005 at 11:05:21PM +0100, Willy Tarreau scribbled:
> Oh, while I'm at it, are you using hyperthreading, and if so, could you
yes, as I wrote in the mail I've just sent - on one box which does NOT
exhibit the problem... :)

> disable it ? I have seen many cases where it degrades performances
> significantly (eg: highly loaded user space network applications).
We saw it in two cases as well, that's why in general we don't run with HT
enabled (although we do test the boxes with it and if it behaves, we leave
it on).

best regards,

marek

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2yIWq3909GIf5uoRAgNjAJ9ZLu99O9QjRdz3hTJ7LWnb7+jLiQCgifrx
4fm2+M/EZukogw7YPAf+cDA=
=fjo5
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
