Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSCGAuS>; Wed, 6 Mar 2002 19:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSCGAuI>; Wed, 6 Mar 2002 19:50:08 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:8320
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S288967AbSCGAuE>; Wed, 6 Mar 2002 19:50:04 -0500
Date: Wed, 6 Mar 2002 16:49:36 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj3 - ide_fops
In-Reply-To: <3C8604FB.1030907@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0203061648330.2886-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Here's another one.

2.5.5-dj3 removes EXPORT_SYMBOL(ide_fops)

but doesn't remove ide_fops from the code.

Hence modprobe ide-cd doesn't work.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hrkjsYXoezDwaVARAq20AJ484wxymank0VdYnX83JPIlMqwJBwCfYWiR
M9S2II7fpkGjPi4D7/yqCvw=
=EbrH
-----END PGP SIGNATURE-----

