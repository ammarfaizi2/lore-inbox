Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVD0TIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVD0TIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVD0TIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:08:06 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:54331 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261967AbVD0THy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:07:54 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
Date: Wed, 27 Apr 2005 21:07:46 +0200
User-Agent: KMail/1.8
References: <200504211941.43889.tais.hansen@osd.dk> <200504261146.15301.tais.hansen@osd.dk> <426EAFF4.3080702@comcast.net>
In-Reply-To: <426EAFF4.3080702@comcast.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3308484.KGZb6pZqnD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504272107.50797.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3308484.KGZb6pZqnD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 26 April 2005 23:17, Andy Stewart wrote:
> I have a patch that partially solves this situation.  My patch allows
> the SATA ATAPI device to be seen, mounted, umounted, and read without
> problem.  Writes to the device fail miserably, and I haven't debugged
> that yet.  Also, the use of the 'dd' command with my patch works unless
> 'dd' is allowed to read off the end of the CD, in which case there is a
> kernel oops (easily reproduced, and I've not yet debugged that failure,
> but I have a theory).
> Since my patch isn't a complete solution, I haven't told anybody about
> it until now.  However, if you are interested in my patch despite its
> limitations, please let me know, and I'll be happy to share it with you.
>   My work was done with the 2.6.11.5 kernel and is limited to one or two
> files, if I recall correctly.

I'd very much like to see what you came up with. I'm currently playing with=
=20
2.6.11.7 but I doubt there's much difference in this area from .5.

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart3308484.KGZb6pZqnD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCb+MGLf7B7mQNLngRAqG4AKDSWHlDsMbvzqLvPkWQti7bo2IB2gCdEw3F
maSRQS8/iYkGwMRAqjOONx8=
=Cf14
-----END PGP SIGNATURE-----

--nextPart3308484.KGZb6pZqnD--
