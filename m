Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTIVM3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTIVM3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:29:19 -0400
Received: from ns2.len.rkcom.net ([80.148.32.9]:4800 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S263124AbTIVM3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:29:17 -0400
From: Florian Schanda <ma1flfs@bath.ac.uk>
Reply-To: ma1flfs@bath.ac.uk
To: Alistair J Strachan <alistair@devzero.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test5-mm4
Date: Mon, 22 Sep 2003 15:30:04 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk>
In-Reply-To: <200309221317.42273.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309221530.17062.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 22 September 2003 13:17, Alistair J Strachan wrote:
> -mm4 won't mount my ext3 root device whereas -mm3 will. Presumably this is
> some byproduct of the dev_t patches.

I don't think this has to do with ext3, since my root xfs partition can't be 
mounted either.

> VFS: Cannot open root device "302" or hda2.
> Please append correct "root=" boot option.
> Kernel Panic: VFS: Unable to mount root fs on hda2.

same over here, except replace hda2 with sda3 and (302 with 803 of couse).

> One possible explanation is that I have devfs compiled into my kernel. I do
> not, however, have it automatically mounting on boot. It overlays /dev
> (which is populated with original style device nodes) after INIT has
> loaded.

I disabled mount at root and created some device nodes, but it still doesn't 
work, befor that I had pure devfs. Reading the config help for devfs says 
it's obsoleted, and stripped down to a "bare minimum to not break anyting". 
Does that "bare minimum" include hard disks?

	Florian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/bwdvfCf8muQVS4cRAmQ0AJ9N6WBJIOKholW9Rf2QV6wdxlWyHACeNsoP
niBAErfeLd0NR0WR6ElKOhU=
=Iysp
-----END PGP SIGNATURE-----

