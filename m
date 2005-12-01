Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVLAMUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVLAMUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVLAMUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:20:22 -0500
Received: from lugor.de ([212.112.242.222]:28328 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S932180AbVLAMUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:20:21 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Subject: Re: [QUESTION] Filesystem like structure in RAM w/o using filesystem (not ramdisk)
Date: Thu, 1 Dec 2005 13:20:02 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <438EE256.6040403@tuleriit.ee>
In-Reply-To: <438EE256.6040403@tuleriit.ee>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1803321.rHgT44oBQo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512011320.10092.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Thu, 01 Dec 2005 13:20:14 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1803321.rHgT44oBQo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 01 December 2005 12:45, Indrek Kruusa wrote:
> Hello!
>
> As I have understood the accessing ramdisk goes through the same kernel
> path which is meant for accessing slow block device (i_nodes caching etc.=
).
> Is there any other common way (some API above shared memory?) to
> create/open/read/write globally accessible hierarchical datablocks in RAM?
> Could it be possibly faster than ramdisk?

You should take a look at tmpfs, I think that is what you search for.
=2D-=20
Christian

--nextPart1803321.rHgT44oBQo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.19 (GNU/Linux)

iD8DBQBDjup6lZfG2c8gdSURAl28AKD7MRfyoehpNaVrXBEBvto0B8TSIgCg7Zn9
f8+GcrE3l2X/inTxgnbS6fY=
=n7bq
-----END PGP SIGNATURE-----

--nextPart1803321.rHgT44oBQo--
