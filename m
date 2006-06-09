Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWFIWwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWFIWwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWFIWwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:52:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43957 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932301AbWFIWwy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:52:54 -0400
Message-Id: <200606092252.k59Mqc2Q018613@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alex Tomas <alex@clusterfs.com>
Cc: Mike Snitzer <snitzer@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Christoph Hellwig <hch@infradead.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: Your message of "Fri, 09 Jun 2006 20:33:18 +0400."
             <m3odx2b86p.fsf@bzzz.home.net>
From: Valdis.Kletnieks@vt.edu
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net> <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net> <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org> <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
            <m3odx2b86p.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149893556_4124P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 18:52:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149893556_4124P
Content-Type: text/plain; charset=us-ascii

On Fri, 09 Jun 2006 20:33:18 +0400, Alex Tomas said:

> one who needs/wants to go back may get rid of extents by:
> a) remounting w/o extents option
> b) copying new-fashion-style files so that copies use blockmap
> c) dropping extents feature in superblock

OK.. Obviously my brain is tiny and easily overfilled.

Given that the whole alledged problem with extents is that they're not
backward compatible, how do you read the files in (b) so that you can copy
them, if the data is in the non-compatible extents that you can't read because
you've disabled extents?

--==_Exmh_1149893556_4124P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEifu0cC3lWbTT17ARAsKCAJ9IdMa1oqgbpZeDe9BCcH20o6jJrQCfcI8z
E6AZSxNZc482HzvEV/psmLU=
=zXiC
-----END PGP SIGNATURE-----

--==_Exmh_1149893556_4124P--
