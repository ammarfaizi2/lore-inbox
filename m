Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTEYOAC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 10:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTEYOAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 10:00:02 -0400
Received: from vsat-148-64-8-86.c119.t7.mrt.starband.net ([148.64.8.86]:260
	"EHLO chaos.mshome.net") by vger.kernel.org with ESMTP
	id S262171AbTEYOAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 10:00:01 -0400
Date: Sun, 25 May 2003 08:12:53 -0600
From: Robert Creager <Robert_Creager@LogicalChaos.org>
To: Bruce Harada <bharada@coral.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with virtually no buffer usage in 2.4.21mdk kernel
Message-Id: <20030525081253.05d4e5f3.Robert_Creager@LogicalChaos.org>
In-Reply-To: <20030525151816.4a433953.bharada@coral.ocn.ne.jp>
References: <20030524223320.7c1ac413.Robert_Creager@LogicalChaos.org>
	<20030525151816.4a433953.bharada@coral.ocn.ne.jp>
Organization: Starlight Vision, LLC.
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.b+5r?LpR9K/e?K"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.b+5r?LpR9K/e?K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hey Bruce,

On Sun, 25 May 2003 15:18:16 +0900
Bruce Harada <bharada@coral.ocn.ne.jp> said something like:

> On Sat, 24 May 2003 22:33:20 -0600
> Robert Creager <Robert_Creager@LogicalChaos.org> wrote:
> 
> > My apparent problem is I'm seeing virtually no buffer usage, as checked from /proc/meminfo
[snip]
> > Buffers:            88 kB
[snip]
> 
> Count the columns - the '0' is for shared memory, not buffers.
> As for why shared memory shows as zero, that's in the FAQ:
> 
>  http://www.tux.org/lkml/#s14-3
> 

That's why I said virtually no buffer usage (not shared memory).  I'm looking at the 88kb (90112).  On my other two systems, both 2.4.19 with 640Mb and 128Mb memory, the buffer usage is 86Mb, and 44Mb respectivly.

Other thoughts?

Thanks,
Rob

-- 
O_

--=.b+5r?LpR9K/e?K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj7Qz2UACgkQgy51bQc2FFlOsACg4nDuT+MHm4oj5QQjfRZhfCFX
A/0AoN8xtMvS3v68WygvlDPkZEM1GwbB
=NjwT
-----END PGP SIGNATURE-----

--=.b+5r?LpR9K/e?K--

