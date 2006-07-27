Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWG0VgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWG0VgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWG0VgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:36:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751303AbWG0VgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:36:05 -0400
Subject: Re: [Ext2-devel] Question about ext3 jbd module
From: Jarod Wilson <jwilson@redhat.com>
To: "bibo,mao" <bibo.mao@intel.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44C8C37B.50405@intel.com>
References: <CA502B3E9EE27B4490C87C12E3C7C85111D033@pdsmsx412.ccr.corp.intel.com>
	 <1154007033.4941.2.camel@sisko.sctweedie.blueyonder.co.uk>
	 <44C8C37B.50405@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+kAJ5FMb5ZHQgOnMOrge"
Organization: Red Hat
Date: Thu, 27 Jul 2006 17:34:47 -0400
Message-Id: <1154036087.7509.8.camel@xavier.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+kAJ5FMb5ZHQgOnMOrge
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-07-27 at 21:45 +0800, bibo,mao wrote:
> System crashed in RHEL4 U3 version, I doubt why there is no judgement
> about whether jh is NULL or not in function journal_dirty_metadata().

We're actually testing a patch we think may fix this problem right now,
assuming this is
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D199667



> Stephen C. Tweedie wrote:
> > Hi,
> >=20
> > On Tue, 2006-07-25 at 17:59 +0800, Mao, Bibo wrote:
> >  > Yes, kernel version is 2.6.9, it is OS distribution kernel RHEL4.
> >=20
> > Which version?  There were a few upstream problems like this fixed in
> > 2.6.11 or so, and I think current RHEL-4 updates should include those.
> >=20
> > I'm off on holiday/family wedding tomorrow for a couple of weeks, so
> > replies might be slow...
> >=20
> > --Stephen


--=20
Jarod Wilson
jwilson@redhat.com


--=-+kAJ5FMb5ZHQgOnMOrge
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEyTF3tO+bni+75QMRAimiAKCkWIr7z87OM0HTStqu3ErkYRn8dQCg2MLS
UgC7/VojCZw7TmDh6FLuIi0=
=16KD
-----END PGP SIGNATURE-----

--=-+kAJ5FMb5ZHQgOnMOrge--

