Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317993AbSGLH01>; Fri, 12 Jul 2002 03:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317995AbSGLH00>; Fri, 12 Jul 2002 03:26:26 -0400
Received: from dsl-213-023-020-198.arcor-ip.net ([213.23.20.198]:23694 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317993AbSGLH00>;
	Fri, 12 Jul 2002 03:26:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ludwig" <cl81@gmx.net>, "Ville Herva" <vherva@niksula.hut.fi>
Subject: Re: bzip2 support against 2.4.18
Date: Fri, 12 Jul 2002 09:30:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship> <000901c2296e$7cab2ed0$1c6fa8c0@hyper>
In-Reply-To: <000901c2296e$7cab2ed0$1c6fa8c0@hyper>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Suso-0002dn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 08:36, Christian Ludwig wrote:
> On 11.07.2001 - 19:21 Daniel Phillips wrote:
> > How about bz2Image, or, more natural in my mind, bz2linux.
> 
> bzImage stands for "big zipped Image".

Yes, I know, and I also know that one can make many foolish arguments in
the name of consistency, but this doesn't change the fact that bz2bzImage
is one of the ugliest symbols we've yet seen, and much worse, it's one
that normal, unsuspecting users are going to come in contact with, if
this code gets into the kernel.

So I'm suggesting it's time to break with tradition try for something a
little less offensive to the eyes.

> Zipped, in this case, means that it
> is gzipped. Perhaps Linus never wants to support other compression formats
> for the kernel.
> Sure "bz2bzImage" is a bit ugly.

"A bit" doesn't begin to describe it.

> I personally would prefer bzImage.bz2,
> although it is some kind of self-extracting executable, thus *.bz2

Exactly, which is why I didn't suggest it.

> is also
> not correct. But it would imply better which sort of compression you are
> using. But that also means that the standard kernel has to be called
> "bzImage.gz". I did not want to mess up the standard names...

There is nothing standard about this name, it exists in exactly one place:
the Linux build process.

> But the question is: who is responsible for all those naming conventions?
> Does anyone has an idea?

You are, it's your patch.  And I've taken upon myself the responsibility
of heaving the decaying vegetables deserved by your first attempt.

Actually, what is the use of even including 'bz2' in the name?  Nobody
besides we geeks needs to know the thing is compressed with bzip2.  It
would be nice to see the word 'linux' in there.  How about bzlinux?
Just think of the hundreds of cases of carpal tunnel syndrome you'd
prevent by eliminating the shifted character.

-- 
Daniel
