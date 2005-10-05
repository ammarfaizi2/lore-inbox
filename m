Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVJEUmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVJEUmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJEUmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:42:24 -0400
Received: from [63.227.222.140] ([63.227.222.140]:22674 "EHLO
	smtp.omgwallhack.org") by vger.kernel.org with ESMTP
	id S1750832AbVJEUmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:42:23 -0400
Date: Wed, 5 Oct 2005 13:41:09 -0700
From: Julian Blake Kongslie <jblake@omgwallhack.org>
To: Marc Perkel <marc@perkel.com>
Cc: 7eggert@gmx.de, Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005134109.757a5e42@kolionychia.omgwallhack.org>
In-Reply-To: <43443723.907@perkel.com>
References: <4TiWy-4HQ-3@gated-at.bofh.it>
	<4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz>
	<43443723.907@perkel.com>
Organization: Fists of Righteous Harmony
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Pretention: High
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Wed__5_Oct_2005_13_41_09_-0700_clQzPPH.H409/=pW";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__5_Oct_2005_13_41_09_-0700_clQzPPH.H409/=pW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Oct 2005 13:27:15 -0700
Marc Perkel <marc@perkel.com> wrote:
> There would be different rights to eack link.

Well, color me confused.

You appear to be saying that the permission on a file differ depending
on which link you are accessing it by. Furthermore, your stance seems to
imply that linking to a file grants either write permission or ownership
on the new link.

So, under this permission model, I could link to /etc/passwd in my
home directory, edit the link to change my UID to zero, then relogin to
the system as an administrator.

Not that I would need to, of course, because any user who owns/could
write to a directory would be able to alter any file on the entire
system. I know they're called "permission" models, but that seems
*extremely* permissive...

--=20
-Julian Blake Kongslie
<jblake@omgwallhack.org>

--Signature_Wed__5_Oct_2005_13_41_09_-0700_clQzPPH.H409/=pW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Don't have my public key? Email <jblake@omgwallhack.org> and I'll gladly mail it to you.

iD8DBQFDRDpsuU009xtCYDURAnvrAJ94FtiSa3IBMGPGYO/kggue7pjYjgCgjjEY
N+vs/S9QV+Ke0lkjr+igqgk=
=y04c
-----END PGP SIGNATURE-----

--Signature_Wed__5_Oct_2005_13_41_09_-0700_clQzPPH.H409/=pW--
