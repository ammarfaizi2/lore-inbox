Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTIFQ6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTIFQ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:58:07 -0400
Received: from mout1.freenet.de ([194.97.50.132]:26000 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261738AbTIFQ6E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:58:04 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: "John Yau" <jyau_kernel_dev@hotmail.com>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sat, 6 Sep 2003 18:57:50 +0200
User-Agent: KMail/1.5.3
References: <LAW12-F92KGb2nHutfS00032a92@hotmail.com>
In-Reply-To: <LAW12-F92KGb2nHutfS00032a92@hotmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309061858.02094.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 06 September 2003 17:58, John Yau wrote:
> Hi Michael,

John,

> I don't know if really a bug due to xmms, I suspect that's the case.  I'm
> not familiar with xmms internals, but when I gdb'ed the process after it
> froze, all the threads either stopped at poll(), write(), select(), or
> nanosleep().

I updated to xmms-1.2.8 final and I didn't see a hang until yet.
I didn't recognize hangs in 1.2.7, so I assume it was some
bug in the beta-versions between 1.2.7 - 1.2.8, which I used and for
which I saw the hangs.
But probably we're not talking about the same problems. :)

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
Animals on this machine: some GNUs and Penguin 2.6.0-test4-bk2

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/WhIWoxoigfggmSgRAkW9AJ4iBpQO1FbnwQzbBfXKb3QALDlXjwCfR6JL
5II9W7tp6Y8733GCB9NxBuk=
=fzvJ
-----END PGP SIGNATURE-----

