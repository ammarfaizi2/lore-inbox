Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWGDHxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWGDHxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWGDHxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:53:50 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:27850 "EHLO
	ns1.mcdownloads.com") by vger.kernel.org with ESMTP
	id S1750804AbWGDHxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:53:48 -0400
Message-ID: <44AA1E83.5020809@fungus.sh.nu>
Date: Tue, 04 Jul 2006 03:53:39 -0400
From: "Daniel T. Chen" <crimsun@fungus.sh.nu>
Reply-To: crimsun@ubuntu.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       James@superbug.demon.co.uk, Daniel T Chen <crimsun@ubuntu.com>,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Ubuntu PATCH] FIx no mpu401 interface can cause hard freeze
References: <44A98261.1000300@oracle.com> <20060704000551.be489377.akpm@osdl.org>
In-Reply-To: <20060704000551.be489377.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Apologies in advance for duplicated subscribers]

Andrew Morton wrote:
>> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=b422309cdd980cfefe99379796c04e961d3c1544
> 
> Do we know who wrote this patch?

It's mine. [0], [1], and [2] contain relevant context as well. The above
commit is insufficient as a fix; the current Ubuntu Dapper kernel
(2.6.15-25.43) does not have the patch from [2].

I have been unable to reproduce the hard freeze using Dapper's current
kernel, but others commenting in [0] are able. The patch from [2] only
seems to lessen the frequency of the freezes on certain hardware.

[0] http://launchpad.net/bugs/34831
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=376382
[2] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952

Thanks,
- --
Daniel T. Chen            crimsun@ubuntu.com
GPG key:   www.sh.nu/~crimsun/pubkey.gpg.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqh35e9GwFciKvaMRAuFhAJ9ez+8Uwy//GfTVyvUpulBPnTxQeQCgpCLB
UAfNw1l1S9esliGWkvNA2so=
=RLDy
-----END PGP SIGNATURE-----
