Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTKCPsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 10:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTKCPsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 10:48:17 -0500
Received: from b107150.adsl.hansenet.de ([62.109.107.150]:38784 "EHLO ds666")
	by vger.kernel.org with ESMTP id S262068AbTKCPsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 10:48:16 -0500
Message-ID: <3FA678B9.5040205@portrix.net>
Date: Mon, 03 Nov 2003 16:48:09 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
References: <3FA62DD4.1020202@portrix.net> <3FA62F18.2050500@cyberone.com.au>
In-Reply-To: <3FA62F18.2050500@cyberone.com.au>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nick Piggin wrote:
|
|
| Jan Dittmer wrote:
|
|> I'm experiencing skips in games like q3demo and enemy territory on a
|> dual xeon p4. That means, if I'm walking around, about every 2-3 seconds
|> I'm skipping a bit of the way. It seems that the clock is running too
|> slow and the games are trying to catch up every x seconds with the
|> system time.
|
|
|
| Please ensure that X is running at priority 0. Report back if you still
| have the problem.

It is. I've been running 2.6 on a dual p2 for quite some time, with good
results. It is also running with priority 0 under 2.4.

| nosmp has been broken for quite a while. If you want to try uniprocessor,
| you'd have to compile a UP kernel.
|
| You should get as good if not better interactivity with SMP enabled,
| however.
|

The problem does not seem interactivity, but some clocks which drift
apart. The framerate is constantly above 100 fps, there are no
background daemons/cron jobs running, remote top doesn't show any
unusual activity. For now, after several reboots and switching back and
forth between 2.6 and 2.4 it seems to be gone under 2.6. I'll see if it
comes back again. I guess a 'vmstat 1` snapshot would be good in this case?

Thanks,

Jan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/pni5LqMJRclVKIYRAu+xAJ0a19pnR40JMDGu+DuKB37CzT3AMQCfZBnH
HHTyLuArV3JnyfNGPbMs40c=
=ARv1
-----END PGP SIGNATURE-----

