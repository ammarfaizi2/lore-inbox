Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUCKMmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUCKMmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:42:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52624 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261221AbUCKMmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:42:33 -0500
Subject: Re: hanging in wait_for_tcp_memory
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Gerald Krafft <gkrafft@porism.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40505CA0.6080702@porism.com>
References: <40505CA0.6080702@porism.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wmN2dQDrZwioz5bkethT"
Organization: Red Hat, Inc.
Message-Id: <1079008948.4446.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 11 Mar 2004 13:42:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wmN2dQDrZwioz5bkethT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-11 at 13:33, Gerald Krafft wrote:
> I have some database processes (Interbase V6) that occasionally seem to=20
> hang. Using ps or top I found that they are waiting in=20
> wait_for_tcp_memory. What exactly does wait_for_tcp_memory do and under=20
> which circumstances does this function block?
> I'm using Red Hat Linux 7.2, kernel version 2.4.7-10smp on a dual=20
> processor machine. Were there any known problems with=20
> wait_for_tcp_memory in that kernel version that might have been fixed in=20
> later versions

2.4.7-10 had a really really bad vm, so we replaced it with another
kernel the day of 7.2 release (which also was needed for security
fixes). Sounds like you need to apply a bunch of (security) errata to
get your system performing better...

--=-wmN2dQDrZwioz5bkethT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAUF6zxULwo51rQBIRAoNnAJ9ALpnruaGRoq6VdAR9AnLa/T+5RgCgiRjn
4bAZgQ4CwRPiiOJAvuLvJH8=
=aHXl
-----END PGP SIGNATURE-----

--=-wmN2dQDrZwioz5bkethT--

