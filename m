Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTJAK0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJAK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:26:38 -0400
Received: from [212.239.225.111] ([212.239.225.111]:49280 "EHLO precious")
	by vger.kernel.org with ESMTP id S261476AbTJAK0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:26:35 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Dave Jones <davej@redhat.com>, marcelo.tosatti@cyclades.com.br
Subject: Re: [2.4.23-pre3] Cache size for Centrino CPU incorrect
Date: Wed, 1 Oct 2003 12:26:09 +0200
User-Agent: KMail/1.5.3
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
References: <7F740D512C7C1046AB53446D3720017304A790@scsmsx402.sc.intel.com> <200309301423.18378.lkml@kcore.org> <20030930140102.GA12812@redhat.com>
In-Reply-To: <20030930140102.GA12812@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310011226.13899.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 30 September 2003 16:01, Dave Jones wrote:
> On Tue, Sep 30, 2003 at 02:23:15PM +0200, Jan De Luyck wrote:
>  > > --- linux-2.4.21/arch/i386/kernel/setup.c	2003-06-13
>  > > 07:51:29.000000000 -0700
>  > > +++ new/arch/i386/kernel/setup.c	2003-07-08 17:21:48.000000000
>  > > -0700
>  > > @@ -2246,6 +2249,8 @@
>  > >  	{ 0x83, LVL_2,      512 },
>  > >  	{ 0x84, LVL_2,      1024 },
>  > >  	{ 0x85, LVL_2,      2048 },
>  > > +	{ 0x86, LVL_2,      512 },
>  > > +	{ 0x87, LVL_2,      1024 },
>  > >  	{ 0x00, 0, 0}
>  > >  };
>  >
>  > This works like a charm. Thanks. Maybe for inclusion in 2.4.23-pre6?
>
> If someone cares enough. I got tired of pushing that patch since 2.4.21.

Marcelo, can this be included in 2.4.23-pre6? It fixed the 0 KB L2 cache for 
Pentium M cpu's.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eqvFUQQOfidJUwQRAvuOAJ446Grj1qUC/sJ2xZ6zjA+sT4xlbACfZXvj
7YhsYbS8hJvD6BBegovaXU4=
=U2o3
-----END PGP SIGNATURE-----

