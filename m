Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132152AbRAaQ0b>; Wed, 31 Jan 2001 11:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132049AbRAaQ0V>; Wed, 31 Jan 2001 11:26:21 -0500
Received: from [209.245.157.113] ([209.245.157.113]:10501 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132152AbRAaQ0R>; Wed, 31 Jan 2001 11:26:17 -0500
Date: Wed, 31 Jan 2001 08:26:15 -0800
From: Christopher Neufeld <neufeld@linuxcare.com>
Message-Id: <200101311626.f0VGQFa24828@localhost.localdomain>
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timur Tabi <ttabi@interactivesi.com>
>
>Besides, why is your client afraid of patched kernels?  It sounds like a very
>odd request from someone with a linuxcare.com email address.  I would think that
>you'd WANT to provide patched kernels so that the customer can keep paying you
>(until they learn how to use a text editor, at which point they can patch the
>kernel themselves!!!)
>
   Well, to be honest, this kernel patch was developed by the client long
before I showed up, I only heard about it yesterday evening when they asked
me to pass it on to linux-kernel. I see your point, but I think it would be
a very strange and magical world where customers line up to pay a company
to apply one-line patches to a header file and type "make" every time a new
kernel comes along.


   There are a few reasons that it would be nice to have such changes in a
standard kernel:

>From the company's point of view:  ease of support.  If the box runs on a
standard Linux kernel it makes it much easier on people who purchase the
boxes.  The company doesn't have to provide patched kernels whenever a new
kernel release comes out, and purchasers can be confident that they won't
find themselves trapped if the company becomes unable or unwilling to
continue to provide those patches.

>From the Linux community's point of view:  flexibility.  Maybe this is the
first computer to pass the 32 PCI bus limit, maybe not.  I really doubt
it's the last, though.  At some point, this will rear up again, and a
kernel which handles the condition gracefully would probably be appreciated
by the people working on this hypothetical future system.

>From the company's point of view:  verification.  I've been told in email
that the correct solution is more subtle than simply increasing this one
value.  The fact that this patch works properly in house is probably
somewhat fortuitous.  Remember the fun when people started increasing the
open file descriptor limits a couple of years ago, and almost getting it
right?  By bringing this patch to the attention of linux-kernel, we point
out a possible need for this functionality to the people who developed the
code in question, and who might be able to fix some subtler gotchas which
were missed when the change was developed.


-- 
 Christopher Neufeld		 		 neufeld@linuxcare.com
 Home page:  http://caliban.physics.utoronto.ca/neufeld/Intro.html
 "Don't edit reality for the sake of simplicity"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
