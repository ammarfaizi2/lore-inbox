Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVCBGmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVCBGmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 01:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVCBGmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 01:42:21 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:7041 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262200AbVCBGmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 01:42:17 -0500
Date: Tue, 1 Mar 2005 23:42:12 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT on 2.4 ext3
Message-ID: <20050302064212.GP27352@schnapps.adilger.int>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.44.0503012129410.2361-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64zwfBjuwM6ycdfi"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0503012129410.2361-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--64zwfBjuwM6ycdfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mar 01, 2005  21:34 -0800, Junfeng Yang wrote:
> I tried to read from a regular ext3 file opened as O_DIRECT, but got the
> "Invalid argument" error.  Running the same test program on a block device
> succeeded.

ext3 doesn't support the direct_IO method in 2.4 kernels, though there
was a patch at one time.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--64zwfBjuwM6ycdfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCJWBEpIg59Q01vtYRAosuAJ4t/M4r6ZxL2hXT94hmamDKP5As1ACcDu2y
2flRsg+0KPSGY2jbf6b42qE=
=0Gpr
-----END PGP SIGNATURE-----

--64zwfBjuwM6ycdfi--
