Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155235-219>; Sat, 12 Dec 1998 20:37:25 -0500
Received: from draal.physics.wisc.edu ([128.104.223.134]:1968 "EHLO draal.physics.wisc.edu" ident: "mcelrath") by vger.rutgers.edu with ESMTP id <160255-219>; Sat, 12 Dec 1998 18:21:57 -0500
Date: Sat, 12 Dec 1998 17:44:18 -0600 (EST)
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Linux kernel mailing list <linux-kernel@vger.rutgers.edu>
Subject: Re: Internationalizing Linux
In-Reply-To: <Pine.LNX.4.02.9812110924020.8473-100000@zaphod.anachem.ruhr-uni-bochum.de>
Message-ID: <Pine.LNX.4.04.9812121724570.3075-100000@draal.physics.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Everyone on this list keeps talking about hash tables, message codes, and
the like.  I don't know if any of you have seen IBM's methodology (used, for
instance, in OS/2) of having message numbers that then must be looked up.
Frankly, it's a massive pain in the ass.  If the message table is missing or
corrupt, there's NO WAY to figure out what error code #6523 means.  And as
someone mentioned, it's useful to check boot messages when no filesystem is
available.

Whatever you do, keep english messages in the kernel.  Perhaps place a
(secondary) error code that can be decoded if necessary (and if the
resources are available).  It's better to have an english error message that
you may have difficulty translating than an error code.  An error code would
require another working computer, web browser, etc,etc...to decipher.  Much
more difficult.  If you had these resources you could use
babelfish.altavista.com to translate the english text anyway!

I don't know if you guys have seen this (appeared on /. in November), but
there's a project to create a "Universal Network Language" that may help
greatly in this arena:
	http://www.news.com/News/Item/Textonly/0,25,29199,00.html

I wish I had further references on it...it looks very interesting...

-- Bob

Bob McElrath (mcelrath@draal.physics.wisc.edu) Univ. of Wisconsin at Madison


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
