Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUBTAlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUBTAlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:41:44 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.74]:50544 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267667AbUBTAaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:30:06 -0500
Date: Thu, 19 Feb 2004 19:29:45 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: sysconf - exposing constants to userspace
In-reply-to: <20040220002034.GC5590@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: thockin@sun.com, Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <200402191929.54604.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.4
References: <20040219204820.GC9155@sun.com>
 <200402191630.47047.jeffpc@optonline.net>
 <20040220002034.GC5590@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 19 February 2004 19:20, Jamie Lokier wrote:
> Jeff Sipek wrote:
> > I think that making something in /sys would make the most sense,
> > with one constant per file. We could dump the consts files to for
> > example /sys/consts, or make a logical directory structure to make
> > navigation easier.
>
> Isn't that very similar to the /proc/sys/kernel we have now?

If I understand the original post correctly, the numbers that we don't make 
available to userspace are compile time constants. For example, since I can't 
think of anything better, NR_CPUS. It is set during the config process, but 
one cannot read the number from userspace while running that kernel. I know 
that there are better examples, but I just can't think of any at the moment.

If I missed the point of the original post, please ignore me.

Jeff.

- -- 
Trust me, you don't want me doing _anything_ first thing in the morning.
		- Linus Torvalds
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFANVUBwFP0+seVj/4RArdbAJ4tsq5cyDJ+058h1D6JDli1nsmP9ACeJnoN
pxE9BuRBNND271SGp81SMHM=
=rmLE
-----END PGP SIGNATURE-----

