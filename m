Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVHWXfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVHWXfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVHWXfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:35:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11420 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751130AbVHWXfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:35:51 -0400
Date: Tue, 23 Aug 2005 18:35:46 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 0/8] PCI Error Recovery patchset
Message-ID: <20050823233545.GA18113@austin.ibm.com>
References: <20050823231817.829359000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20050823231817.829359000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



What follows is a set of patches to implement a PCI error recovery
system.  Some (newer) PCI controllers are able to detect and report=20
PCI errors, these patches enable this hardware function.

-- the first patch adds documentation, explaining what this is and how
   it works.
-- the next patch adds core infrastructure to include/linux/pci.h
-- the next several patches add recovery support to three ethernet and
   two scsi drivers.
-- the last patch is a big monster that implements the recovery
   driver for the ppc64-specific pci controllers.


The first seven patches should apply cleanly to just about any recent
kernel tree; the last patch requires GregKH's pci patchset, since some
ppc64 functions changed recently.


--linas


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7LNZKmaggEEWTMRAqHZAJ46LMGvztRGSC5//nOncNg8YwBN3wCff3UY
jQ/oW68q3QyvmFAIJ8AHyU0=
=9xTO
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
