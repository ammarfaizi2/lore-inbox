Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbTALTys>; Sun, 12 Jan 2003 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTALTys>; Sun, 12 Jan 2003 14:54:48 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:21396 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267445AbTALTyr>; Sun, 12 Jan 2003 14:54:47 -0500
Date: Sun, 12 Jan 2003 14:59:57 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 14:38, Linus Torvalds wrote:
> I think goto's are fine

You're a relatively succesful guy, so I guess I shouldn't argue with
your style.

However, I have always been taught, and have always believed that
"goto"s are inherently evil.  They are the creators of spaghetti code
(you start reading through the code to understand it (months or years
after its written), and suddenly you jump to somewhere totally
unrelated, and then jump somewhere else backwards, and it all gets ugly
quickly).  This makes later debugging of code total hell.  

Would it be so terrible for you to change the code you had there to
_not_ use a goto and instead use something similar to what I suggested? 
Never mind the philosophical arguments, I'm just talking good coding
style for a relatively small piece of code.

If you want, but comments in your code to meaningfully describe what's
happening instead of goto labels.

In general, if you can structure your code properly, you should never
need a goto, and if you don't need a goto you shouldn't use it.  It's
just "common sense" as I've always been taught.  Unless you're
intentionally trying to write code that's harder for others to read.

-Rob

