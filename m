Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269434AbUHZTnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269434AbUHZTnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUHZTkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:40:16 -0400
Received: from ns2.arlut.utexas.edu ([146.6.211.1]:54283 "EHLO
	ns2.arlut.utexas.edu") by vger.kernel.org with ESMTP
	id S269489AbUHZTir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:38:47 -0400
Date: Thu, 26 Aug 2004 14:36:17 -0500
From: Jonathan Abbey <jonabbey@arlut.utexas.edu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, christer@weinigel.se, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826193617.GA21248@arlut.utexas.edu>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 26, 2004 at 09:28:41PM +0300, Denis Vlasenko wrote:
|
| Is it possible to sufficiently hide "dirs inside files"
| so that old tools will be unable to see them?
|=20
| I just checked:
|=20
| ls -d /foo  does lstat64("/foo", ...)
| ls -d /foo/ does lstat64("/foo", ...)
| 	but
| ls -d /foo/. does lstat64("/foo/.", ...)
|=20
| Will it work out if "dir inside file" will only be visible when referred =
as "file/."?

I'm used to using ls symlink/. to get ls to show me the directory on
the far side of a symbolic link.  That's a pretty analagous case to
the one we're discussing here, I think?

 Jon

--=20
---------------------------------------------------------------------------=
----
Jonathan Abbey 				              jonabbey@arlut.utexas.edu
Applied Research Laboratories                 The University of Texas at Au=
stin
GPG Key: 71767586 at keyserver pgp.mit.edu, http://www.ganymeta.org/workkey=
.gpg

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (SunOS)

iD8DBQFBLjuxGI9EwHF2dYYRAragAJ9DcI5AB3TZLclfHo5e3Y5dS6JxdwCg0/6u
AyQiinzuItKB7ATsWEZNni8=
=3fHv
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
