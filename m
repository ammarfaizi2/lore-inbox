Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUFSQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUFSQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbUFSQsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:48:52 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:12976 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264461AbUFSQiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:38:16 -0400
Message-ID: <40D46BED.2010901@kolivas.org>
Date: Sun, 20 Jun 2004 02:38:05 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck1
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406182004370.32121@alpha.polcom.net> <200406191406.45750.kernel@kolivas.org> <40D3CE68.2000403@kolivas.org> <Pine.LNX.4.58.0406191824030.4764@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0406191824030.4764@alpha.polcom.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Grzegorz Kulewski wrote:
|
| On Sat, 19 Jun 2004, Con Kolivas wrote:
|
|
|>Con Kolivas wrote:
|>
|>>On Sat, 19 Jun 2004 04:35, Grzegorz Kulewski wrote:
|>>
|>>
|>>>Hi Con,
|>>>
|>>>I have two problems with 2.6.7-ck1. My distribution is Gentoo Linux
|>>>unstable with all latest updates. Oh, yes, both 2.6.7-ck1 and 2.6.7-rc3
|>>>I tested have vesafb-tng applied from http://dev.gentoo.org/~spock/, but
|>>>it should not cause any problems because it is very non-intrusive
patch I
|>>>think. Maybe you should include this in your patchset?
|>>>
|>>>1. When booting init script freezes after starting input hotplugging (it
|>>>is udev system). The only way to make it run is to press Ctrl-Alt-SysRQ
|>>>and various keys to display kernel state several times. After that
system
|>>>starts normally. I do not know if it is only -ck problem because I had
|>>>no time to test 2.6.7 vanilla, but 2.6.7-rc3 worked fine. (Log
included.)
|>>
|>>
|>>Yes I have a sneaking suspicion it's related to the fact kernel
threads are
|>>fixed priority at the moment in staircase (they dont descend priority
like
|>>normal tasks so act like relatively low priority real time tasks). I'm
|>>addressing that for the next version so hopefully that will fix it.
|>
|>Here's a diff for -ck1 which brings you up to staircase7.1
|>Can you try that?
|
|
| It does not solve the problem for me, sorry...

Ok I'll keep looking. That change was necessary anyway.

Thanks,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA1GvtZUg7+tp6mRURAk4MAJ9xJ49Mwyv/Qlb5M4Dm8acsto5kRgCdEtIp
WE4lkMOxIh3HB+IET/oEs9c=
=4ayV
-----END PGP SIGNATURE-----
