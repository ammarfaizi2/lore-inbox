Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269067AbUICEhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269067AbUICEhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269061AbUICEhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:37:43 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:24252 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S267732AbUICEhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:37:31 -0400
Message-ID: <4137F4FF.3070608@slaphack.com>
Date: Thu, 02 Sep 2004 23:37:19 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Dukes <pakrat@www.uk.linux.org>
CC: Spam <spam@tnonline.net>, viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <4137B5F5.8000402@slaphack.com> <1862674154.20040903024407@tnonline.net> <4137C8B4.2030009@slaphack.com> <20040903034448.GJ32697@ZenIV.linux.org.uk>
In-Reply-To: <20040903034448.GJ32697@ZenIV.linux.org.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris Dukes wrote:
| On Thu, Sep 02, 2004 at 08:28:20PM -0500, David Masover wrote:
|
|>So implement a plugin which knows how to talk to a userland program
|>which knows about metadata.  The plugin controls access to file-type.
|>
|>Maybe there ought to be a general-purpose userland plugin interface?  So
|>that the only things left in the kernel are things that have to be there
|>for speed and/or sanity reasons?  (Things like cryptocompress and
|>standard file/directory plugins.)
|
|
| Ahem,
| Wasn't this the goal of GNU HURD?

The goal of GNU HURD was to take everything out of the kernel and make
it entirely daemons.  That's a far cry from keeping a file-type database
(historically the realm of file managers) out of the kernel.

Most people hate putting things in the kernel that don't belong there.
Most of what's in the kernel is for speed and/or sanity -- filesystems
are there for speed, device drivers (and scheduling, and vm, and so on)
are there for sanity.

Correct me if I'm wrong on this.

| I really think you should ask them why they haven't delivered
| something useful, then come back to this thread.

Honestly?  I think it's mostly got nothing to do with architecture.  I
think it's mostly got to do with politics.  Most people would rather
hack on Linux, which is already done, than try to develop HURD, which is
something new.  Most people also enjoy working with Linus (or prefer
Linus to the FSF).

I do not like how Linux is monolithic.  I do not like having to reboot
to upgrade the kernel, and I do not like having to run closed software
(the nvidia drivers) in the kernel (as in, full privelages, can crash
entire system, yadda yadda).  But Linux is the best we have.

The HURD people have delivered at least something.  I think there's even
a Debian/HURD distro.  Whether it's useful probably has to do with
whether it's stable/fast, which isn't likely.  You hear of Linux news
every day, you hear of HURD maybe once in a lifetime -- "Hey, HURD exists!"

But you are right -- I need to take a break from this thread.  It's
becoming addictive, and it's hard keeping up with so many people who are
so much smarter than I am.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTf0/3gHNmZLgCUhAQKGrw//XMBsWBo7uqlocjdvSati4GkxsB+f2GPW
hI3JboYhWVMB7Ya+mS9VbrruxVn7uCCUwLwNDDnMncHTf09Em+WhzwJCQXZ14Y2r
AxZ8iaVR9Qv8hIHGw59uJYWvtTSHgSmWiFFVa4UB4D3NneSFr2vgXXDbU8LjhHQB
46qs8IM6s+RCb0L608uGml6AmyrxFvDgWz9p+++tWicLjQPVhBnLQQnqYy92we7x
qUwxCyGQywmdcSsJlkcjKzLQ/dCDwQRq7LXmSCx3qbSRr27D6zpE6l9He62ZuoBR
I9NmO12S6VgYifO5fnq6pxSu2+GuJVW469tm7EiXmKZ/rjfMJKp0cqg+mtGTU91m
gk7cZTBbe4id9+IQPJPJJ08IMH5XTI4DI6dXCkKIB0TZ8teFnU2+DsUdZ50ZXwiL
etFUjortzjPjEqZoKfvK+4n7HOMu1w1og/7aE6P5UNTbj5ViwLQB9KjwLBDyBMJr
dTmcLRyxzHtDZJMQuLwvU/SsdF86CdlR4spkEI6CitRMiiWvYghOeOkasOO8qxVj
ckzZzUCRHNF/PTPSAEiIaw2HyjVzf0Nru96Y80/hik3hRYO0XuTP/3K/twHoebkz
Fo1NLtGU3g631pDYcpqnkkAcQN+3fiyZ3VEiNoYYLhZpkQiEH8goRv5lof9XJPAC
krhwM8lNHoM=
=JJEe
-----END PGP SIGNATURE-----
