Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTJSKqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 06:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTJSKqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 06:46:24 -0400
Received: from mout2.freenet.de ([194.97.50.155]:1493 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261509AbTJSKqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 06:46:23 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Sun, 19 Oct 2003 12:45:46 +0200
User-Agent: KMail/1.5.4
References: <200310180018.21818.rob@landley.net> <1066477155.5606.34.camel@sonja> <3F91E01C.4090507@cyberone.com.au>
In-Reply-To: <3F91E01C.4090507@cyberone.com.au>
Cc: Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org,
       rob@landley.net
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310191245.55961.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 19 October 2003 02:51, Nick Piggin wrote:
> Daniel Egger wrote:
> >I quick test with a PowerPC kernel and the normal vmlinux image reveals
> >that this is nonsense.
> >
> >-rwxr-xr-x    1 root     root      2766490 2003-09-27 22:29 vmlinux
> >-rwxr-xr-x    1 root     root      1149410 2003-09-27 22:29 vmlinux.gz
> >-rwxr-xr-x    1 root     root      1062999 2003-09-27 22:29 vmlinux.bz2
> >
> >This is a 86411 bytes or 8.1% reduction, seems significant to me...
>
> Sure, it might be worth it in some cases. I didn't mean improvement
> wasn't measurable at all.

What about making it configurable? If someone want's bzip2
and if he want's to wait longer to boot, (s)he may
compile bzip2 support.
If someone dislikes it, (s)he may use gzip.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/kmtjoxoigfggmSgRAqNAAJ9isDDlHbCBTWleCMMtd7/AtaogBACcDu8o
tg6ggQ+w3nyn933Po7tRJ5I=
=jft8
-----END PGP SIGNATURE-----

