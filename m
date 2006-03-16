Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWCPVRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWCPVRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWCPVRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:17:41 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16589 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751445AbWCPVRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:17:40 -0500
Message-Id: <200603162117.k2GLHAvU021040@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE 
In-Reply-To: Your message of "Thu, 16 Mar 2006 08:29:51 PST."
             <20060316082951.58592fdc.rdunlap@xenotime.net> 
From: Valdis.Kletnieks@vt.edu
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org>
            <20060316082951.58592fdc.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142543830_2870P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2006 16:17:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1142543830_2870P
Content-Type: text/plain; charset=us-ascii

On Thu, 16 Mar 2006 08:29:51 PST, "Randy.Dunlap" said:

> nah, the only place that using symbolic names for true and false
> is a problem is when someone #defines or enums them bassackwards.

Or goes off the deep end and does something like:

enum bool = {false, true, unknown};

http://thedailywtf.com/forums/47844/ShowPost.aspx
http://thedailywtf.com/forums/61792/ShowPost.aspx

Gaak.  Unfortunately, they might someday try to write kernel code. ;)

--==_Exmh_1142543830_2870P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEGdXWcC3lWbTT17ARAh5gAKD5VOeRJZtpUXqpOZcewgZ7zgFadgCfWdEt
UDAdSznPUFGWIxhor4lBr/k=
=9JV5
-----END PGP SIGNATURE-----

--==_Exmh_1142543830_2870P--
