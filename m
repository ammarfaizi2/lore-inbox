Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUIGTmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUIGTmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIGTj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:39:29 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:34997 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268504AbUIGTiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:38:21 -0400
Date: Tue, 7 Sep 2004 13:38:19 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@lst.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unexport get_wchan
Message-ID: <20040907193819.GS27331@schnapps.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907144539.GA8808@lst.de> <1094576868.9607.7.camel@localhost.localdomain> <20040907181130.GA12595@lst.de> <1094578157.9607.25.camel@localhost.localdomain> <20040907184907.GA13331@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JB7KW7Ey7eB5HOHs"
Content-Disposition: inline
In-Reply-To: <20040907184907.GA13331@lst.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sep 07, 2004  20:49 +0200, Christoph Hellwig wrote:
> Well, you kdb cotains quite a few other patches to core code already,
> no?  And it could add back a single EXPORT_SYMBOL in a common place
> instead of duplicated over every architecture..

I think most projects' goals is to reduce the number of patches they need
to make to the kernel instead of increasing them...  If you think it is
ugly to have multiple EXPORT_SYMBOLS() then it should just be moved to
the line after the function definition.  Having to add another configure
rule to check for now-unexported symbols isn't my idea of time well spent
(not that I care about this one in particular).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--JB7KW7Ey7eB5HOHs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBPg4rpIg59Q01vtYRAir7AKCYUlbMZafvfzMAADG9gqpx02dgQwCfYNp4
2s1TCfyljFZRrO9LzRyG50k=
=XMKk
-----END PGP SIGNATURE-----

--JB7KW7Ey7eB5HOHs--
