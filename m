Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUATPCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbUATPCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:02:13 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:65201 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S265290AbUATPCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:02:08 -0500
Date: Wed, 21 Jan 2004 01:59:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ross Burton <ross@burtonini.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM and ACPI sleep issues with 2.6
Message-Id: <20040121015903.0b4198b0.sfr@canb.auug.org.au>
In-Reply-To: <1074520065.32688.9.camel@carados.180sw.com>
References: <1073232351.21389.111.camel@localhost>
	<20040105140057.096c77f9.sfr@canb.auug.org.au>
	<1074520065.32688.9.camel@carados.180sw.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__21_Jan_2004_01_59_03_+1100_7XHV5ErjceYKA_XT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__21_Jan_2004_01_59_03_+1100_7XHV5ErjceYKA_XT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2004 13:47:45 +0000 Ross Burton <ross@burtonini.com> wrote:
>
> On Mon, 2004-01-05 at 03:00, Stephen Rothwell wrote:
> > > With 2.6.1-rc1-mm, when I shut the lid with APM enabled nothing
> > > happens.  No messages on the console, nothing.
> > 
> > Can you try booting with apm=debug and see if you get any messages
> > when you shut the lid.
> 
> Sorry for the long delay...

I was actually wondering if there are any messages beginning with "apm:"

> Looks like e100 (network) and intel8x0 (sound) recovered okay.  The
> second time I shut the lid, when I opened it the keyboard had locked up.
> 
> I've been told that building 2.6.1-mm4, making i8042 and atkdb modules
> and unloading them before sleeping should fix this problem.  Is that the
> blessed solution?  Unloading the modules for the keyboard controller
> does seem a little too much like brute-force for me, especially since
> 2.4.x managed fine. :)

I am not sure if you need to build i8042 and atkb as modules amy more, I
thought there was a fix applied (in 2.6.1?).  However it would be
interesting to the results of removing the modules before suspending.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Jan_2004_01_59_03_+1100_7XHV5ErjceYKA_XT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADUI3FG47PeJeR58RArxfAKDWQQHrmxXT219Ak8xN/sNi/QPjxgCggNuI
bmYoKWONmAk1HshSnoH7sIU=
=iT3F
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Jan_2004_01_59_03_+1100_7XHV5ErjceYKA_XT--
