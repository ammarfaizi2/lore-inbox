Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271828AbTGXXdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271829AbTGXXdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:33:32 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:20998 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271828AbTGXXda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:33:30 -0400
Date: Thu, 24 Jul 2003 16:48:37 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire
Message-ID: <20030724234837.GC23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <20030724231421.GQ1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20030724231421.GQ1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2003 at 07:14:21PM -0400, Ben Collins wrote:
> I've seen this before, but I can never reproduce it. Not with i386, nor
> with sparc64, and not running 2.4 or 2.6. I know what is happening
> though. The response packet is getting processed before the status
> packet (IOW, the ack for your request is getting back after the actual
> response to your request).
>=20
> Not sure how that is possible, but I suspect it's just a bit of logic
> that needs to be applied, or queue the replies waiting for the ack.

That is very odd, considering it works under 2.4.  Is it possible the
pending_packets list isn't being updated?  Would the verbose debug option
help?

Thanks for looking into this.
-Chris

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IHBVKO6EG1hc77ERAnojAKDD2swqDRleTa6GH0Wk8xYSQ6YNiACgubWa
EViVQzFru7TbcytnRLlXeqo=
=EvQq
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
