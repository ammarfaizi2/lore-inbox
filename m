Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTKBRPl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 12:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTKBRPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 12:15:41 -0500
Received: from h80ad263a.async.vt.edu ([128.173.38.58]:57318 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261753AbTKBRPj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 12:15:39 -0500
Message-Id: <200311021715.hA2HFXr5026778@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Brian Beattie <beattie@beattie-home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right 
In-Reply-To: Your message of "Sun, 02 Nov 2003 08:11:32 EST."
             <1067778693.1315.76.camel@kokopelli> 
From: Valdis.Kletnieks@vt.edu
References: <1067778693.1315.76.camel@kokopelli>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1458627488P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Nov 2003 12:15:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1458627488P
Content-Type: text/plain; charset=us-ascii

On Sun, 02 Nov 2003 08:11:32 EST, Brian Beattie <beattie@beattie-home.net>  said:

> for storage might be feasible soon.  The idea is that you have a
> permanent store, using raid or raid-like redundancy and file versioning
> so that nothing is ever deleted, you just keep adding drives and
> replacing those that fail.  Of course you'd need some geographic
> diversity and a way for storage to migrate to newer "file stores" to
> really work, but just think, no more backups to fail...ever!   

This may be very nice for the high end, but getting "geographic diversity"
means you have to get space in a colo of some sort (unless you're a big enough
site that you have another building of your own at least a mile or two away),
and bandwidth between the two sites.

Somehow, I don't see this anytime soon for the home user, the SOHO user, or the
small company that has 7-8 internal servers and a T-1.

Remember that for this to work, the bandwidth and off-site storage has to be
available at a cost the user can afford.  Remember that a lot of people aren't
too happy with the current price point for cable or DSL access - and those
price points are set with a high overcommital of bandwidth.  If everybody
starts trying to do backups over the network, the provider will have to build
out more capacity, and raise the price to cover it.

Yes, we're looking at offsite disk mirroring as a backup solution.  But we're
lucky that we have a large open space in a switch room some 3 miles from the
data center and dark fiber from here to there.  But it's STILL going to be a
big chunk of change. I dread to think what it would cost per month if we had to
pay for the space and bandwidth.


--==_Exmh_1458627488P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/pTu0cC3lWbTT17ARAvGyAJ4uyjMCJhz78LuOvY5+Wa0jZvvcfACgrJbt
iA5nKnNWStTBMhYLPiAtse8=
=Ov+g
-----END PGP SIGNATURE-----

--==_Exmh_1458627488P--
