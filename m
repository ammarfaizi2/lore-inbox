Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUCIOHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUCIOHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:07:23 -0500
Received: from hc652af67.dhcp.vt.edu ([198.82.175.103]:1664 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261951AbUCIOGw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:06:52 -0500
Message-Id: <200403090444.i294iZRw002717@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1 
In-Reply-To: Your message of "Sun, 07 Mar 2004 22:32:21 PST."
             <20040307223221.0f2db02e.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040307223221.0f2db02e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_911182314P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Mar 2004 23:44:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_911182314P
Content-Type: text/plain; charset=us-ascii

On Sun, 07 Mar 2004 22:32:21 PST, Andrew Morton <akpm@osdl.org>  said:

> +dm-maplock.patch
> 
>  Add an rwlock to the device mapper maptable management so that
>  +queue-congestion-dm-implementation.patch does not try to take a semaphore
>  inside a spinlock.

Just an ack that this does fix the problem I reported against the -rc1-mm2
version of the queue-congestion stuff...

--==_Exmh_911182314P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFATUuycC3lWbTT17ARAm3LAJ9nyV+wHIPRYh0WfmeS5VXisEanCgCfZFss
i6YAtEdumKzGBk0Hb8Bk4Bo=
=co4P
-----END PGP SIGNATURE-----

--==_Exmh_911182314P--
