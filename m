Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131904AbQKQKyr>; Fri, 17 Nov 2000 05:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131933AbQKQKy3>; Fri, 17 Nov 2000 05:54:29 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:46169 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131904AbQKQKyN>; Fri, 17 Nov 2000 05:54:13 -0500
Date: Fri, 17 Nov 2000 10:24:11 +0000
From: Tim Waugh <twaugh@redhat.com>
To: John Cavan <johncavan@home.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (new for ppa and imm) Re: [PATCH] Re: Patch to fix lockup on ppa insert
Message-ID: <20001117102411.S6735@redhat.com>
In-Reply-To: <3A13D4BA.AD4A580B@home.com> <3A13D8D6.8C12E31A@home.com> <20001116162027.C597@suse.de> <3A149D00.9D38FA24@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="hEarWVD7htqb1VxP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A149D00.9D38FA24@home.com>; from johncavan@home.com on Thu, Nov 16, 2000 at 09:50:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hEarWVD7htqb1VxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2000 at 09:50:40PM -0500, John Cavan wrote:

> [...] This patch unlocks, allows the lowlevel driver to do it's
> probes, and then relocks. It could probably be more granular in the
> parport_pc code, but my own home tests show it to be working fine.

Is that safe?

Also, what bit of the parport code is tripping over the lock?
Request_module or something?

A nicer fix would probably be to use parport_register_driver, but
that's likely to be too big a change right now.

Tim.
*/

--hEarWVD7htqb1VxP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6FQdKONXnILZ4yVIRAkW4AJwOQcf0NHM5QxP7WnuMnhUccMhybwCgnE9/
Z6nvx1dOdzbfsPy91pgWwmk=
=WSVc
-----END PGP SIGNATURE-----

--hEarWVD7htqb1VxP--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
