Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVD2OUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVD2OUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVD2OUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:20:33 -0400
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:56490 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262697AbVD2OT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:19:57 -0400
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
Date: Fri, 29 Apr 2005 15:19:52 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt> <20050427181609.GA21785@electric-eye.fr.zoreil.com>
In-Reply-To: <20050427181609.GA21785@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1634244.13CzhCzAsP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504291519.52558.pjvenda@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1634244.13CzhCzAsP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 27 April 2005 19:16, Francois Romieu wrote:
> Pedro Venda (SYSADM) <pjvenda@rnl.ist.utl.pt> :
> [...]
>
> > Not being able to see the whole stacktrace on screen, we've started a
> > netconsole to investigate. Started the server and loaded it pretty bad
> > with rsyncs and such... until it crashed after just 20 minutes.
> >
> > The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"
>
> Is it reproducible if you disable both preempt and netconsole ?

not sure yet.=20

please note that netconsole was added AFTER some crashes to analise the cra=
sh=20
dump, so I don't think it's directly related.

keep in mind that this is a production machine.

I'll sure test the same kernel without preemption and post results.

thanks.

regards,
pedro venda.
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administra=E7=E3o de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior T=E9cnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt

--nextPart1634244.13CzhCzAsP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCckKIeRy7HWZxjWERAhEkAJ95hWG8o6qDwbNa01vQsDfJGVZQfQCfTNVU
uMV9M1oSgdABtnHXo5NWBqE=
=IbST
-----END PGP SIGNATURE-----

--nextPart1634244.13CzhCzAsP--
