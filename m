Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTH2GpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 02:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTH2GpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 02:45:13 -0400
Received: from D7182.pppool.de ([80.184.113.130]:10146 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264438AbTH2GpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 02:45:06 -0400
Subject: Re: UP optimizations ..
From: Daniel Egger <degger@fhm.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: herbert@13thfloor.at,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <16204.62914.298711.293389@gargle.gargle.HOWL>
References: <20030827160315.GD26817@www.13thfloor.at>
	 <16204.62914.298711.293389@gargle.gargle.HOWL>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2n4AfUZH6IbNO+jkpJEC"
Message-Id: <1062058995.965.2.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Aug 2003 10:23:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2n4AfUZH6IbNO+jkpJEC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2003-08-27 um 20.17 schrieb Mikael Pettersson:

> +#else
> +
> +static inline int task_cpu(const struct task_struct *p)
> +{
> +	return 0;
> +}
> +
> +static inline void set_task_cpu(struct task_struct *p, int cpu)
> +{
> +}
> +
> +static inline unsigned long task_cpus_allowed(const struct task_struct *=
p)
> +{
> +	return ~0UL;
> +}
> +
> +static inline void set_task_cpus_allowed(struct task_struct *p,
> +					 unsigned long cpus_allowed)
> +{
> +}
> +
> +static inline void set_task_cpus_runnable(struct task_struct *p,
> +					  unsigned long cpus_runnable)
> +{
> +}
> +
> +#endif /* CONFIG_SMP */

Shouldn't these be marked const?

--=20
Servus,
       Daniel

--=-2n4AfUZH6IbNO+jkpJEC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Tbvzchlzsq9KoIYRAgILAKDcKFFmQVSiT47ZN8dHHmZrIXCOaQCdHkGR
ySzvc2bLeiahR9039/7C6g8=
=XUdf
-----END PGP SIGNATURE-----

--=-2n4AfUZH6IbNO+jkpJEC--

