Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTLDAff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLDAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:35:35 -0500
Received: from smtp3.cwidc.net ([154.33.63.113]:63978 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S262765AbTLDAf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:35:28 -0500
Message-ID: <3FCE810F.3050100@tequila.co.jp>
Date: Thu, 04 Dec 2003 09:34:23 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com> <20031203204518.GA11325@alpha.home.local>
In-Reply-To: <20031203204518.GA11325@alpha.home.local>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Willy Tarreau wrote:
| On Wed, Dec 03, 2003 at 07:01:39PM +0000, bill davidsen wrote:

| For instance, time typically reports 0.03u, 0.03s, 2.8 real. It seems as
| each line sent to xterm consumes one full clock tick doing nothing. I
| never reported it yet because I don't have time to investigate, and it
| seems more important that people don't hear skips in xmms while compiling
| their kernel with "make -j 256" on a 16 MB machine. Second test : launch
| 10 times : xterm -e "find /" & and look how some windows freeze for up
| to 10 seconds... I don't think this is a problem right now. We've seen
| lots of work in the scheduler area, many people proposing theirs, and
| this will stabilize once 2.6 is out and people start to describe what
| they really do with it and what they feel.

Well, I had to try that here. I've got a Celeron 650Mhz with 320MB ram
and a crappy 14GB HD and yes the finds in the xterms are stopping for
some time ... BUT X is 100% responsive. there is no sluggishness, I can
use mozilla, etc without a problem. so seriously, who makes 10 finds at
the same time and finds are read from FS (I have XFS) so it might be a
problem with that. So I don't think the scheduler is bad, I think it is
great. When I switched to 2.5 the first time on that box it was like
"WOW", so little swapping and KDE is so smooth ... thats so wow ...

Still there are some minor problems (japanese keyboard eg) but that will
smooth out when Programs get adapted.

But for your problem, it might get better for these kind of things in
later versions :)

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

iD8DBQE/zoEPjBz/yQjBxz8RAjsEAKCO3Nvs/5r/6HgRh9Z83T2SlQmfIgCfQHl5
jbHM0IQVD/buJjD/I2Shv9k=
=YOth
-----END PGP SIGNATURE-----

