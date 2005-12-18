Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbVLRWL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbVLRWL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbVLRWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:11:29 -0500
Received: from smtp06.auna.com ([62.81.186.16]:51439 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S965292AbVLRWL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:11:28 -0500
Date: Sun, 18 Dec 2005 23:14:01 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: About 4k kernel stack size....
Message-ID: <20051218231401.6ded8de2@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs93 (GTK+ 2.8.9; i686-pc-linux-gnu)
To: nel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_k+28=n5xw0up1oXA0nR=nls";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Sun, 18 Dec 2005 23:11:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_k+28=n5xw0up1oXA0nR=nls
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi...

I'm following the intense thread about stack size, and I see only one
solution.

Ship the nest stable, development, -mm, everything release of everything
with a maximum kernel/interrupt stack usage meter. The ask a poll for
everyone to send  /proc/sys/stack_usage_max to a mailing list.

Until that, you wont know if current code is razoring the 4k limit or
never passes the 1K size.

Just one idea, to try to end with this endless flamewar.

BTW, I run 4k stacks in 3 boxes since long ago, and had 0 (zero) problems.
Including nsf/afp over ext3 on md.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam5 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_k+28=n5xw0up1oXA0nR=nls
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDpd8pRlIHNEGnKMMRAixPAKCjTJW51f9Cbz7goeMwLnZg69+1FgCfQ3EM
DknhXfK2LIEkH77XmrAcoTQ=
=w/AQ
-----END PGP SIGNATURE-----

--Sig_k+28=n5xw0up1oXA0nR=nls--
