Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUHELLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUHELLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbUHELLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:11:41 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:46739 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S267638AbUHELJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:09:02 -0400
Date: Thu, 5 Aug 2004 13:08:47 +0200
From: Martin Waitz <tali@admingilde.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: OLS and console rearchitecture
Message-ID: <20040805110847.GA919@admingilde.org>
Mail-Followup-To: Jon Smirl <jonsmirl@yahoo.com>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	lkml <linux-kernel@vger.kernel.org>
References: <410E55AA.8030709@ums.usu.ru> <20040802161656.32244.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20040802161656.32244.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Aug 02, 2004 at 09:16:56AM -0700, Jon Smirl wrote:
> When user space dies on shutdown output would switch over to the kernel
> based console - the reverse process of what happens on start up. Do we
> need more?

Yes, killall5 is not the last thing that runs in userspace.

Unmounting and stuff is done later and still has to be able to produce
visible output, so we still need our console daemon.

On bootup, console will be set up first, so there won't be any output
from userspace without the console daemon running

--=20
Martin Waitz

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBEhU+j/Eaxd/oD7IRAs66AJ9BaLcAPeYsa84/IOp+xKK1Jo/mDwCdFmJO
bEd7nbDlr35MENuosWGEeso=
=L01q
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
