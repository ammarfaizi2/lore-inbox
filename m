Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSHDP30>; Sun, 4 Aug 2002 11:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSHDP3Z>; Sun, 4 Aug 2002 11:29:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:5005 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317872AbSHDP3Z>;
	Sun, 4 Aug 2002 11:29:25 -0400
Date: Sun, 4 Aug 2002 17:32:45 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE reduction, prefetch fixes and other CPU-related changes
Message-Id: <20020804173245.1e3254f7.sebastian.droege@gmx.de>
In-Reply-To: <1028471237.1294.515.camel@ldb>
References: <1028471237.1294.515.camel@ldb>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.:FT(C+i:FVe8cm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:FT(C+i:FVe8cm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 04 Aug 2002 16:27:16 +0200
Luca Barbieri <ldb@ldb.ods.org> wrote:
[...]
>  if [ "$CONFIG_MK7" = "y" ]; then
>     define_int  CONFIG_X86_L1_CACHE_SHIFT 6
> @@ -115,6 +144,26 @@
>     define_bool CONFIG_X86_GOOD_APIC y
>     define_bool CONFIG_X86_USE_3DNOW y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
> +   define_bool CONFIG_X86_686 y
> +   define_bool CONFIG_X86_MMX y
> +   define_bool CONFIG_X86_MMXEXT y
> +   define_bool CONFIG_X86_3DNOW y
> +   define_bool CONFIG_X86_3DNOWEXT y
> +   define_bool CONFIG_X86_USE_SSE_PREFETCH y
> +fi
Hi,
is there really support for SSE prefetch in athlons _without_ SSE?!
I don't know but this seems wrong...

Bye
--=.:FT(C+i:FVe8cm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9TUkge9FFpVVDScsRApRFAJ4g/Z7uTg6WHOlUyAQyf/wAUZ9TtQCfaT3z
erkd3T0Oq0jPghbayqtic34=
=2t9c
-----END PGP SIGNATURE-----

--=.:FT(C+i:FVe8cm--

