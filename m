Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVA1UMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVA1UMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVA1ULW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:11:22 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:31621 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262736AbVA1UGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:06:04 -0500
Message-ID: <41FA9B37.1020100@comcast.net>
Date: Fri, 28 Jan 2005 15:06:15 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why does the kernel need a gig of VM?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Can someone give me a layout of what exactly is up there?  I got the
basic idea

K 4G
A 3G
A 2G
A 1G

App has 3G, kernel has 1G at the top of VM on x86 (dunno about x86_64).

So what's the layout of that top 1G?  What's it all used for?  Is there
some obscene restriction of 1G of shared memory or something that gets
mapped up there?

How much does it need, and why?  What, if anything, is variable and
likely to do more than 10 or 15 megs of variation?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+ps2hDd4aOud5P8RApCsAJ47J2Ye2YGljChTIETunRTUeM8kIQCfZyU2
Vm49zyAQONLuD4tScid3sSw=
=bxPu
-----END PGP SIGNATURE-----
