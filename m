Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVJDEaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVJDEaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 00:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVJDEaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 00:30:17 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64443 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751181AbVJDEaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 00:30:16 -0400
Message-ID: <434204F8.2030209@comcast.net>
Date: Tue, 04 Oct 2005 00:28:40 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: The price of SELinux (CPU)
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've heard that SELinux has produced benchmarks such as 7% increased CPU
load.  Is this true and current?  Is it dependent on policy?  What is
the policy lookup complexity ( O(1), O(n), O(nlogn)...)?  Are there
other places where a bottleneck may exist aside from gruffing with the
policy?  Isn't the policy actually in xattrs so it's O(1)?  Where else
would an overhead that big come from aside from a lookup in a table?

....

Why is the sky blue?  Why do you have a mustach?  Why doesn't mommy have
one?  Does she shave it?

At any rate, my personal end goal is a secure high-performance operating
system, as user friendly as Ubuntu, Mandriva, or Win----.  To this end,
I'm (still; a lot of you have seen me before) evaluating the performance
hit of various user and kernel security enhancements like PaX,
ProPolice, various OpenWall/GrSecurity niceness that needs to be divided
out, and of course LSM/SELinux.  Also wondering about that PHKMalloc
thing on openbsd; is it really all that, is it junk, how's it compare to
the recent ptmalloc work, and can it run on Linux for direct benching .
. . but that's off topic.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDQgT4hDd4aOud5P8RAoWBAJ0foEe4JcqDDlb7mMXQ6Z6FjCFjLACfdmJz
+j2lCH7DpTlZK6zUztldEGI=
=RzhA
-----END PGP SIGNATURE-----
