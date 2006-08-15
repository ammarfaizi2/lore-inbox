Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbWHOMpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbWHOMpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbWHOMpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:45:53 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:39043 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751243AbWHOMpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:45:52 -0400
Date: Tue, 15 Aug 2006 22:45:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: viro@ftp.linux.org.uk, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits
Message-Id: <20060815224540.04177ed9.sfr@canb.auug.org.au>
In-Reply-To: <9787.1155633947@warthog.cambridge.redhat.com>
References: <20060815090243.GT29920@ftp.linux.org.uk>
	<20060815013114.GS29920@ftp.linux.org.uk>
	<20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
	<20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com>
	<7619.1155630777@warthog.cambridge.redhat.com>
	<9787.1155633947@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__15_Aug_2006_22_45_40_+1000_r2L3twscLeq4K0xi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__15_Aug_2006_22_45_40_+1000_r2L3twscLeq4K0xi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Aug 2006 10:25:47 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Interestingly, one of these also touches userspace: /proc/locks passes the
> inode number out, but will pass the wrong one if i_ino is too short.  Does
> anything in userspace actually use that?

As far as I know, /proc/locks is just useful for debugging the locking code.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Aug_2006_22_45_40_+1000_r2L3twscLeq4K0xi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE4cH0FdBgD/zoJvwRArSCAJsENtwn7XSvHh2PtduZTsJVmlBkiwCgmdjD
5WHpOFZpWEa7W1ybUvzKaU4=
=2oDf
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Aug_2006_22_45_40_+1000_r2L3twscLeq4K0xi--
