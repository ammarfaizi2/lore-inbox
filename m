Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVBGW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVBGW3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVBGW3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:29:41 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:32235 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261254AbVBGW3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:29:38 -0500
Message-ID: <4207EBD4.9090104@comcast.net>
Date: Mon, 07 Feb 2005 17:29:40 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Filesystem linking protections
References: <1107802626.3754.224.camel@localhost.localdomain> <20050207111235.Y24171@build.pdx.osdl.net> <4207C4C7.8080704@comcast.net> <20050207120516.A24171@build.pdx.osdl.net>
In-Reply-To: <20050207120516.A24171@build.pdx.osdl.net>
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
>>I've yet to see this break anything on Ubuntu or Gentoo; Brad Spengler
>>claims this breaks nothing on Debian.  On the other hand, this could
>>potentially squash the second most prevalent security bug.
> 
> 
> Yes I know, I've worked on distro with it as well in the past.  And it
> has broken atd and courier in the past.  This is something that also
> can be done in userspace using sane subdirs in +t world writable dirs,
> or O_EXCL so there's work to be done in userspace.
> 

Yes, mkdtemp() and mkstemp().

Of course we can't always rely on programmers to get it right, so the
idea here is to make sure we ask broken code to behave nicely, and stab
it in the face if it doesn't.  Please try to examine this in that scope.

> thanks,
> -chris

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCB+vThDd4aOud5P8RAssCAJ9L7Cf5pnvI8GdKs1P4cpM2lJvtYACZAXee
a5kkPkxXm9YK0DFSfvDd6fQ=
=00DK
-----END PGP SIGNATURE-----
