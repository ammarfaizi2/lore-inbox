Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTLDKNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTLDKNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:13:33 -0500
Received: from smtp2.cwidc.net ([154.33.63.112]:47017 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S261753AbTLDKNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:13:31 -0500
Message-ID: <3FCF08C7.3020100@tequila.co.jp>
Date: Thu, 04 Dec 2003 19:13:27 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com> <20031203204518.GA11325@alpha.home.local> <3FCE810F.3050100@tequila.co.jp> <20031204053318.GB16903@alpha.home.local>
In-Reply-To: <20031204053318.GB16903@alpha.home.local>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Willy Tarreau wrote:
| On Thu, Dec 04, 2003 at 09:34:23AM +0900, Clemens Schwaighofer wrote:

| Production workloads are typically different. Perhaps my 10 xterms produce
| the same type of load as 10 persons grepping gigs of logs from memory ?
| And perhaps my "ls -ltr" produce the same workload as... someone searching
| a recent file with "ls -ltr"

well I don't know, I don't use this box full time, but quite a lot, I do
a lot of compiling on it. Run Mozilla, etc on it, copy big files, etc,
but I never had any serious "lock" problems, where everthing freezes for
a second like I have from time to time in 2.4

|>So I don't think the scheduler is bad, I think it is
|>great. When I switched to 2.5 the first time on that box it was like
|>"WOW", so little swapping and KDE is so smooth ... thats so wow ...
|
|
| I too think it's great and smoother than 2.4. It obviously makes a
difference
| if you use X (and I don't use these KDE, etc...). But the smoothness was
| also brought to 2.4 by patches such as rmap, preempt, variable-hz. All of
| them have been merged into 2.6, so we cannot deny that they helped too.

well on my working bux I run 2.4.22-ck3 and this has a lot of preempt
workstation speedup stuff inside, but it still freezes from time to time
if there is a peak in workload.

|>But for your problem, it might get better for these kind of things in
|>later versions :)
|
| -test10 was NOK. I'll try test11, and when I've time I'll try Nick's
| scheduler too.

well test11 is very smooth. I haven't tried Nick scheduler but I might
give it a shot, just to see how the "xterm craziness" goes ... :)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/zwjGjBz/yQjBxz8RAmJyAJ4jA3q9yqaYxIjI3PT1ueHHwjUeuACeOWdS
Lp4cfDBErPBrd0df27xRygY=
=ffb4
-----END PGP SIGNATURE-----

