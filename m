Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbSJJUv0>; Thu, 10 Oct 2002 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264024AbSJJUv0>; Thu, 10 Oct 2002 16:51:26 -0400
Received: from c66-235-4-135.sea2.cablespeed.com ([66.235.4.135]:23901 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id <S264021AbSJJUvZ>; Thu, 10 Oct 2002 16:51:25 -0400
Date: Thu, 10 Oct 2002 13:53:44 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0  -  (NUMA))
Message-Id: <20021010135344.220b57f9.thomas@zimres.net>
In-Reply-To: <3DA31152.FD9A819E@digeo.com>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE>
	<1281002684.1033892373@[10.10.2.3]>
	<E17ybuZ-0003tz-00@starship>
	<3DA1D30E.B3255E7D@digeo.com>
	<3DA1D969.8050005@nortelnetworks.com>
	<3DA1E250.1C5F7220@digeo.com>
	<20021008023654.GA29076@netnation.com>
	<3DA247F3.B1150369@digeo.com>
	<20021008124948.GA1572@tricia.dyndns.org>
	<3DA31152.FD9A819E@digeo.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.nQGHWDGUQUw_mP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.nQGHWDGUQUw_mP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Oct 2002 10:09:38 -0700
Andrew Morton <akpm@digeo.com> wrote:
[snip]
> Well the initial approach was to put the minimum functionality
> in-kernel and drive it all from userspace.  I that proved to
> be inadequate then the kernel-side might need to be grown.
> 
> I'd expect that a defrag would be a batch process which is done
> during quiet times.  Although one _could_ have a `defragd' which
> ticks along all the time I suppose.
> 
> A defragmentation algorithm probably would not be a "per file" thing;
> it would need to gather a fair amount of state about the fs, or
> at least an individual block group before starting to shuffle things.

I seem to remember a "drive optimzier" on an old SE Mac. It would move
files and dirs about so that commonly used files all sat together. It
would run in the background too...after the disk was idle for about 5
minuest (configurable, iirc) it would go to work moving things about. It
really helped, as programs and used libs usually all sat in nice self
contained directories. I wounder if load times could be significantly
reduced by having libraries/programs fault in w/o all the seeking that
goes on on X load; as I first test, I guess, I'll have to see if
"prefaulting" all the X/kde dependences in help much.

Thomas "all lurk, no code" Zimmerman



--=.nQGHWDGUQUw_mP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9pejeOStTnUTb5R8RArqlAJ42FSr2MP0ZgRDl1TT4JZn2x5kqMwCfXyco
hHq3lvtfzlFSkxG/vX5AYi0=
=xdwg
-----END PGP SIGNATURE-----

--=.nQGHWDGUQUw_mP--
