Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUHTHXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUHTHXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHTHXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:23:05 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:20355 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S267633AbUHTHUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:20:47 -0400
Date: Fri, 20 Aug 2004 00:19:05 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, nickpiggin@yahoo.com.au
Subject: Re: Possible dcache BUG
Message-ID: <20040820001905.27a9ff8f@laptop.delusion.de>
In-Reply-To: <20040820001154.0a5cf331.akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040820000238.55e22081@laptop.delusion.de>
	<20040820001154.0a5cf331.akpm@osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__20_Aug_2004_00_19_05_-0700_h0OCs19U.tQrZP/m"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_Aug_2004_00_19_05_-0700_h0OCs19U.tQrZP/m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 20 Aug 2004 00:11:54 -0700 Andrew Morton (AM) wrote:

AM> "Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
AM> >
AM> > I've tried to download 700 MB of data from a digital camera via USB using
AM> >  "gphoto2 --get-all-files" and I can repeatedly run my 128 MB box out of
AM> >  memory using either Linux 2.4.26 or 2.6.8.1 for that.
AM> 
AM> whee.  How much swap is online?

Something close to 512 MB.

Adding 506512k swap on /dev/hda2.  Priority:-1 extents:1

AM> Not that it matters - you seem to have a bunch of reclaimable pagecache
AM> just sitting there.  Very odd.
AM> 
AM> Could gphoto2 be using mlock?  Does it run as root?

No, gphoto2 was not running as root.

-Udo.

--Signature=_Fri__20_Aug_2004_00_19_05_-0700_h0OCs19U.tQrZP/m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJaXpnhRzXSM7nSkRAmx3AJ0Xm0J9k0iZagfsEp6wnqsKUUeUJQCfRE0M
Ex+6PaD1j+0yyqm57sAV0Zo=
=f7aO
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Aug_2004_00_19_05_-0700_h0OCs19U.tQrZP/m--
