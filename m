Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVBHCKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVBHCKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 21:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVBHCKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 21:10:19 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12726 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261383AbVBHCKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 21:10:11 -0500
Message-ID: <42081F87.4040707@comcast.net>
Date: Mon, 07 Feb 2005 21:10:15 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Filesystem linking protections
References: <1107802626.3754.224.camel@localhost.localdomain> <20050207111235.Y24171@build.pdx.osdl.net> <4207C4C7.8080704@comcast.net> <20050207120516.A24171@build.pdx.osdl.net> <4207EBD4.9090104@comcast.net> <20050207144734.C469@build.pdx.osdl.net>
In-Reply-To: <20050207144734.C469@build.pdx.osdl.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Chris Wright wrote:
> * John Richard Moser (nigelenki@comcast.net) wrote:
> 
>>Yes, mkdtemp() and mkstemp().
>>
>>Of course we can't always rely on programmers to get it right, so the
>>idea here is to make sure we ask broken code to behave nicely, and stab
>>it in the face if it doesn't.  Please try to examine this in that scope.
> 
> 
> It's fine for hardened distro.  But still inappropriate for mainline.
> 

Perhaps in mainline as an option?  The [*] notations next to things are
really nice, they let you turn kernel stuff on and off :)  It's
appropriate for mainline to support added security isn't it?  I think
following the path of supporting-but-not-forcing is the best route,
because it encourages people to account for systems which may take
advantage of such options, and thus leads to a software base in which
it's quite sane to actually enable those options globally.

That's just how I think though.

> thanks,
> -chris

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCCB+GhDd4aOud5P8RAlD9AJ45JTY20WY6qHe0h0ZIcFasgxJDtACbB1aB
i4hytMAy6Cs1AUNXC296JOk=
=oLVs
-----END PGP SIGNATURE-----
