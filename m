Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbTAMAaI>; Sun, 12 Jan 2003 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTAMAaH>; Sun, 12 Jan 2003 19:30:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267685AbTAMAaF>;
	Sun, 12 Jan 2003 19:30:05 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1810.4.64.197.173.1042418332.squirrel@www.osdl.org>
Date: Sun, 12 Jan 2003 16:38:52 -0800 (PST)
Subject: Re: any chance of 2.6.0-test*?
To: <robw@optonline.net>
In-Reply-To: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
        <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
X-Priority: 3
Importance: Normal
Cc: <torvalds@transmeta.com>, <hch@infradead.org>, <greg@kroah.com>,
       <alan@lxorguk.ukuu.org.uk>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2003-01-12 at 14:38, Linus Torvalds wrote:
>> I think goto's are fine
>
> You're a relatively succesful guy, so I guess I shouldn't argue with your
> style.

Good.  (although I don't know why I'm replying as this thread
is way overdone....:)

> However, I have always been taught, and have always believed that
> "goto"s are inherently evil.  They are the creators of spaghetti code (you
> start reading through the code to understand it (months or years after its
> written), and suddenly you jump to somewhere totally
> unrelated, and then jump somewhere else backwards, and it all gets ugly
> quickly).  This makes later debugging of code total hell.
>
> Would it be so terrible for you to change the code you had there to _not_
> use a goto and instead use something similar to what I suggested?  Never
> mind the philosophical arguments, I'm just talking good coding style for a
> relatively small piece of code.
>
> If you want, but comments in your code to meaningfully describe what's
               or put
> happening instead of goto labels.
>
> In general, if you can structure your code properly, you should never need a
> goto, and if you don't need a goto you shouldn't use it.  It's just "common
> sense" as I've always been taught.  Unless you're
> intentionally trying to write code that's harder for others to read.

There are goto-less languages, even Algol-like ones.
And OSes can be written in them.
Well, they just have different names for JUMP.

~Randy



