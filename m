Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269643AbUHZV3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269643AbUHZV3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269691AbUHZV2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:28:06 -0400
Received: from hostmaster.org ([212.186.110.32]:13458 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S269643AbUHZVZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:25:17 -0400
Subject: Re: netfilter IPv6 support
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.netfilter.org
In-Reply-To: <20040826130024.6ff83dff.davem@redhat.com>
References: <1093546367.3497.23.camel@hostmaster.org>
	 <20040826130024.6ff83dff.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XrcRMAdNuVNjVm2Zh+Tn"
Date: Thu, 26 Aug 2004 23:25:10 +0200
Message-Id: <1093555510.3497.33.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XrcRMAdNuVNjVm2Zh+Tn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Don, 2004-08-26 at 13:00 -0700, David S. Miller wrote:
> Stateful netfilter is not there because it's a total waste
> to completely duplicate all of the connection tracking et al.
> code into ipv6 counterparts when %80 of the code is roughly
> the same.  People are working on a consolidation of these
> things so that there is no code duplication but it is a lot
> of work and there are bigger fires to put out at the moment.

Of course it's a waste to duplicate the code but as far as I remember
the status of netfilter for IPv6 has not changed for almost a year. As
said there is still not even the basic REJECT target available.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

The three Rs of Microsoft support: Retry, Reboot, Reinstall.



--=-XrcRMAdNuVNjVm2Zh+Tn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQEVAwUAQS5VNmD1OYqW/8uJAQKj+Af+KX8fHtgVq2vziIu508/BOXQ7U7TOn+7m
sLy7/n+mC516PjTlq1fP0m4tKAo+MI6bFDfWRvjsqnBp3sW2nL6G2jiCSvgxWSR1
ImucDWvlyUpxkrH3zab/GYpW9l2+CkN7NuxrmFaUfHrWsKLVJ4ZoBSZkoTxwSOuj
P9Hp5IHEiNHVS/C8isj6S0mxDUQAmSzFwuSKQvVQ0cx+JuyxC8kLG4EsKIxd8r4U
KflZDAfPNnm6On9akp7UohYLGAqWy7tFtXEa0pro2sxSIzLMbw1Kopau5zFEioPh
N2RYA7Ch5YnPtEH0QaC3NJ7ThImxWeDS+o5l2ttU2YIxFfT0ZnmqxA==
=atN8
-----END PGP SIGNATURE-----

--=-XrcRMAdNuVNjVm2Zh+Tn--

