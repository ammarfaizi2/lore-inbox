Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUIDNbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUIDNbV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUIDNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:31:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261232AbUIDNaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:30:52 -0400
Date: Sat, 4 Sep 2004 15:30:50 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
Message-ID: <20040904133050.GC15382@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0409041053450.25475@skynet> <1094292878.2801.7.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409041126500.25475@skynet> <20040904103711.GD5313@devserv.devel.redhat.com> <Pine.LNX.4.58.0409041418450.25475@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041418450.25475@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 04, 2004 at 02:23:30PM +0100, Dave Airlie wrote:
> 
> Okay here is an updated patch:
> 
> I've taken suggestions from Christoph and Arjan on board,
> 
> My only issue is with the stuff in drm_os_linux.h, I've had to make a
> dummy AGP structure, and add the mtrr_add/mtrr_del stubs (as they are fine
> on x86 but don't exist on anything else..) but perhaps a small ugly in
> there is better than big uglies elsewhere...

I like it

 
> I might be able to drop the OS_HAS_AGP from the drivers, but that'll be a
> job that requires testing via CVS (as that is where we have the people
> with the different cards..)

well Rome wasn't built on one day either; this sure is a step in the right
direction.


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBOcOKxULwo51rQBIRApDTAJ9ed3HRK7fVTlygROOQcmGs/GnX2QCbBiO6
UQ3jpn91Ttn/CyOAcG5mUOA=
=Ey0X
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
