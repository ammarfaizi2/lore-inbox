Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264357AbUEMSG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUEMSG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUEMSG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:06:59 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:14310 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264357AbUEMSGn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:06:43 -0400
Message-Id: <200405131806.i4DI6gqp002109@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1: nameif causes oops 
In-Reply-To: Your message of "Thu, 13 May 2004 19:28:49 +0200."
             <20040513172849.GA2188@middle.of.nowhere> 
From: Valdis.Kletnieks@vt.edu
References: <20040513172849.GA2188@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-559958486P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 May 2004 14:06:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-559958486P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 May 2004 19:28:49 +0200, Jurriaan <thunder7@xs4all.nl>  said:
> In my untainted 2.6.6-mm1 kernel, I see an oops (the one with the turtle
> graphics) when booting, caused by the usage of nameif (which renames
> ethernet interfaces from 'eth0' to 'adsl' for example).

Already shot, there's a patch that goes on -mm1:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108426973229787&w=2

This is already in -mm2 as sysfs-backing-store-sysfs_rename_dir-fix.patch
I believe...

--==_Exmh_-559958486P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAo7kxcC3lWbTT17ARAjVIAKDTVuZKQl7LjX29P4lGh+LbP+Qu0wCfaPaN
4Dagnq4/ddFA9QD4z9pnPpw=
=Hwqx
-----END PGP SIGNATURE-----

--==_Exmh_-559958486P--
