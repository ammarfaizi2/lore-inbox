Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbUJ1QTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUJ1QTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUJ1QTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:19:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:30463 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261714AbUJ1QOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:14:48 -0400
Message-ID: <41811AF2.2000503@comcast.net>
Date: Thu, 28 Oct 2004 12:14:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michael@optusnet.com.au
CC: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>	<200410261719.56474.edt@aei.ca>	<Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>	<417F315A.9060906@comcast.net> <m1sm7znxul.fsf@mo.optusnet.com.au>
In-Reply-To: <m1sm7znxul.fsf@mo.optusnet.com.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



michael@optusnet.com.au wrote:
| John Richard Moser <nigelenki@comcast.net> writes:
| [ .. lots of stuff .. ]
|
|>Let's make 2.7 what 2.6 is now (a relatively stable kernel that gets
|>relatively stable feature enhancements continuously), rather than what
|>2.5 was (a hell of a lot of patches and then a hell of a lot of
|>debugging), and make 2.6 more restrictive than 2.4 in that it should be
|>strictly bugfixes (including security bugs) and no backported drivers or
|>features.
|
|
| There seems to be a lot of strange notions on this concept of 'stable'.
| The only thing that makes a kernel 'stable' is time. Not endless
| bugfixes. Just time. The idea of stable software is software that not
| going to give you any suprises, software that you can trust.
|

Right.  Bugfixing the "Stable" branch ONLY will make sure it does not
surprise you with sudden new features (which may surprise you by. . .
breaking your own patches!).

| That's NOT the same as bug free software. For a start, there's no such
| thing.

5-50 per KLOC.

| For another, many bugs are perfectly acceptable in a production
| environment as long as they're not impacting. (The linux kernel is a
| very large piece of work. Few installations would use even 20% of the
| total kernel functionality).
|
| If you want a stable kernel version, pick one (almost any one will
| do). Test the hell of out it with your application(s). If it fails,
| fix the bug, or pick a different version. rinse, repeat.
|
| Now you've got a kernel that tests clean with your app. DON'T
| CHANGE IT!!
|
| Ta-Dah! You've got a stable kernel.
|

That if I keep my realtime patches or my security enhancements or my new
drivers or my new filesystems on and don't continuously upgrade will
cause me to stagnate and be left behind and ignored.

I've already heard rumors (very few, and they've been squashed) of
GrSecurity being abandoned.  The authors of both PaX and Gr are both
active, they're just spinning on 2.6.7.

Do you see the scenario occuring here?  Their project is obviously
inferior in many peoples' minds because it's not the latest
hot-off-the-LKML 2.6 kernel.  Indeed, many security fixes in (soon to
be) 2.6.10 aren't in 2.6.7, which could provide known ways to easily
slip straight past PaX and Gr (I haven't done my research, but this is
not a hollow scenario).

| Now why would you change it? The only possible reasons
| are that your testing was terrible and you missed a bug,
| in which case you can go back to step 1, or that you
| want a new feature. In which case you can go back to
| step 1.
|
| That wasn't too hard, was it. Even better, you didn't see
| anything in there about 2.6 v 2.7 or other such fluff.
|
| Michael.
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBgRrxhDd4aOud5P8RArUKAJ97tfBLjXCGYQx1DiR0Iul0mwa2FgCfXZMS
vi6YYB8ik6IWO441jZPX5oI=
=YvZq
-----END PGP SIGNATURE-----
