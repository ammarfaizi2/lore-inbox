Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTEZSOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTEZSOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:14:32 -0400
Received: from vsat-148-64-8-86.c119.t7.mrt.starband.net ([148.64.8.86]:260
	"EHLO chaos.mshome.net") by vger.kernel.org with ESMTP
	id S261944AbTEZSOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:14:30 -0400
Date: Mon, 26 May 2003 12:26:55 -0600
From: Robert Creager <Robert_Creager@LogicalChaos.org>
To: Bruce Harada <bharada@coral.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with virtually no buffer usage in 2.4.21mdk kernel
Message-Id: <20030526122655.0042c298.Robert_Creager@LogicalChaos.org>
In-Reply-To: <20030527024141.5b168415.bharada@coral.ocn.ne.jp>
References: <20030524223320.7c1ac413.Robert_Creager@LogicalChaos.org>
	<20030525151816.4a433953.bharada@coral.ocn.ne.jp>
	<20030525081253.05d4e5f3.Robert_Creager@LogicalChaos.org>
	<20030527024141.5b168415.bharada@coral.ocn.ne.jp>
Organization: Starlight Vision, LLC.
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.ok:ag0eV+yI3GP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ok:ag0eV+yI3GP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2003 02:41:41 +0900
Bruce Harada <bharada@coral.ocn.ne.jp> said something like:

> On Sun, 25 May 2003 08:12:53 -0600
> Robert Creager <Robert_Creager@LogicalChaos.org> wrote:
> 
> > That's why I said virtually no buffer usage (not shared memory).  I'm
> > looking at the 88kb (90112).  On my other two systems, both 2.4.19 with
> > 640Mb and 128Mb memory, the buffer usage is 86Mb, and 44Mb respectivly.
> > 
> > Other thoughts?
> 
> Ah, my apologies. As for why your buffer usage is so low, it's likely a bit
> difficult to tell whether it's indicative of a problem without knowing what
> patches have been applied to the Mandrake kernel. Also, I believe the buffers
> value these days isn't as useful a metric as it used to be, so personally I
> wouldn't worry about it too much, unless you're seeing problems with the box.
> 

I'm not seeing any problems that I'm aware of, just trying to eak out a little more performance out of the box, and the lack of disk buffer usage seems suspicious.

I may try backing of to a known released kernel, and see what happens...

Cheers,
Rob

-- 
O_

--=.ok:ag0eV+yI3GP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj7SXH8ACgkQgy51bQc2FFk2tgCcCEP8DyTqGOoSLeTOXsacVjlN
qGkAn19MzucjjYir8aVlwfF6HVNtXgJz
=uoZ3
-----END PGP SIGNATURE-----

--=.ok:ag0eV+yI3GP--

