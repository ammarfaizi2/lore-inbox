Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbTIXFZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 01:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTIXFZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 01:25:56 -0400
Received: from h80ad269b.async.vt.edu ([128.173.38.155]:50048 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261326AbTIXFZw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 01:25:52 -0400
Message-Id: <200309240518.h8O5IYcw005735@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       bcrl@kvack.org, ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64 
In-Reply-To: Your message of "Tue, 23 Sep 2003 15:58:29 PDT."
             <DD755978BA8283409FB0087C39132BD101B01197@fmsmsx404.fm.intel.com> 
From: Valdis.Kletnieks@vt.edu
References: <DD755978BA8283409FB0087C39132BD101B01197@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1580433968P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Sep 2003 01:18:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1580433968P
Content-Type: text/plain; charset=us-ascii

On Tue, 23 Sep 2003 15:58:29 PDT, "Luck, Tony" said:
> Alan Cox wrote:
> > On Maw, 2003-09-23 at 19:21, Luck, Tony wrote:
> > > a) the programmer is playing fast and loose with types and/or casts.
> > > b) the end-user is going to be disappointed with the performance.
> > 
> > c) the programmer is being clever and knows the unaligned access is
> > cheaper on average than the cost of making sure it cant happen
> 
> Which is great until the "cleverly written" program is fed a data set
> that pushes into the unaligned case far more frequently than the
> programmer anticipated.

Didn't we recently fix a DoS attack on the TCP stack that was basically this
sort of thing with hashes?  And crafting an attack against this would be a lot
simpler than the hash-function attack.....

--==_Exmh_-1580433968P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/cSkqcC3lWbTT17ARArzLAKCmZ0L+QeMvsMtsNJ7WF+FKE01+swCfcCn2
i7kRo3EGWP8yKi4kus7OqVQ=
=Bzqo
-----END PGP SIGNATURE-----

--==_Exmh_-1580433968P--
