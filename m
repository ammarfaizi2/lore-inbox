Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVF1TcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVF1TcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVF1Tas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:30:48 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:1796 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261163AbVF1T2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:28:03 -0400
Message-ID: <42C1A4C2.4090704@slaphack.com>
Date: Tue, 28 Jun 2005 14:28:02 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean <seanlkml@sympatico.ca>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alexander Zarochentsev <zam@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: Message from Alexander Zarochentsev <zam@namesys.com>    of "Mon,    27 Jun 2005 13:30:06 +0400." <200506271330.07451.zam@namesys.com>    <200506281401.j5SE1ORW003589@laptop11.inf.utfsm.cl> <4783.10.10.10.24.1119984732.squirrel@linux1>
In-Reply-To: <4783.10.10.10.24.1119984732.squirrel@linux1>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sean wrote:
> On Tue, June 28, 2005 10:01 am, Horst von Brand said:
> 
>>>I don't belive that you want to see all reiser4-specific things as item
>>>plugins, disk format plugins in the VFS.
>>
>>Only what makes sense. Plus many of those will probably have to go. Decide
>>on /one/ way of doing things, even if not perfect for all uses. Everything
>>else is useless bloat.
> 
> 
> It doesn't seem to be a problem as long as loadable plugins are GPL.  How

"Loadable" how?

reiser4 plugins must be compiled in, either directly to the kernel, or
part of reiser4.ko

The only thing "loadable" about them is that some can be turned on or
off for individual files.

> is it useless bloat?  It doesn't seem much different from having loadable
> modules in the security system.  Just don't enable Reiser4 in your kernel
> if you don't want to use it.

This is not getting us anywhere.  It seems to be an issue of overall
design and neatness at this point.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsGkwXgHNmZLgCUhAQKUlw/6AxzaT+5R7lzhy4d/W55KY7m+8QJA90Ut
3m+E/hiSKykolERURKUoRPEK+jly8DUxLS+UpA5ZQwxzkR4YipMcoW5i3lHyJ9GB
Hf9lBtGu0TwCF8W9Qh1Fk/7mwQcvyz6ATUYOYqvSA5Wxfr8BDFdcJUqTwMRCOxrA
Fh5oOSBXEhqnSElfvurBkzMNurOmNnkpeZt8rM6qXqeYRRPrmIWmFGvkufoyb/q7
N2wdwtwoubWokl8FLWHQmH0f4pJqJUNXpDQvw67zKi24zOUq8ZZ7xH7EE8vNI9s9
ppVVsrLiAFE2/GeDRIdbQNSuClliq7XZV4AMHkorik7Qe0nIeR4hBr9hYI41l/Ie
G3A9yP/69XsOodUWMZB/asxj3zMEhDynz26t98C2S858eRA7EJLcJ+IU1HnxHv7N
KUcZLUyMP6DPDcm3r2FtjvwDwneQwk3zBqFE30DgAERZTgZ7RTglVuyBhETryk3m
ZIf6bjuwnqn2/TFC7Yqwf9tzHshx91ywkfpOXwc/3IcrKKpfY74Mp4Cj/LkRemoz
LnE6DdpjuNpMmwTwV0Vb5FKkfeO2nFkLZ96z8HphNmAAINh7gP3bpUMaODc8fLDG
HtpzloYmBa4Yvn9JX+AwFuQStupPmScwa62Gcyv0Zm5EQ6fB1pqY1HdhpLHvXehT
l0i+8OO74B0=
=NI4M
-----END PGP SIGNATURE-----
