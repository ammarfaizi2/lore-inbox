Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263071AbSJGPHq>; Mon, 7 Oct 2002 11:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263074AbSJGPHq>; Mon, 7 Oct 2002 11:07:46 -0400
Received: from AGrenoble-101-1-4-166.abo.wanadoo.fr ([217.128.202.166]:51841
	"EHLO elessar.linux-site.net") by vger.kernel.org with ESMTP
	id <S263071AbSJGPHp>; Mon, 7 Oct 2002 11:07:45 -0400
Message-ID: <3DA1A842.1050105@wanadoo.fr>
Date: Mon, 07 Oct 2002 17:29:06 +0200
From: FD Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: best version for server?
References: <20021007080132.A13486@work.bitmover.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Larry McVoy wrote:
| We're not sure if it is something we've done or just increased usage, but
| bkbits.net is getting hammered lately.  We see load averages in ~15-20
| range pretty regularly.  It's got some nasty characteristics from the
| point of view of server/VM system, tons of data and not really any good
| working sets.  I'm running 2.4.5 on it and that clearly has to go.  I am
| going to try the rmap kernel but I'm open to other suggestions.

I've been running 2.4.17 + O(1) patch for a while on a pretty
heavily loaded server (dual CPU) and it works like a charm.

I've put 2.4.19+O(1) on the test machine, it seems to behave OK.

2.4.1[7,9] have Andrea's VM BTW.

I think I still have the sources of the 2.4.17 O(1) patch...
somewhere, if you want to try, just email me.

Cheers,

- --

F. CAMI
- ----------------------------------------------------------
~ "To disable the Internet to save EMI and Disney is the
moral equivalent of burning down the library of Alexandria
to ensure the livelihood of monastic scribes."
~              - John Ippolito (Guggenheim)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9oahCuBGY13rZQM8RAsjiAJ9GVYb9V/xj28noF/GmjIpVv13IbwCfQU4t
V8GUthptR6y3lUVKNONLtPY=
=Wy/K
-----END PGP SIGNATURE-----

