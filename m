Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262936AbREWBRS>; Tue, 22 May 2001 21:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbREWBRI>; Tue, 22 May 2001 21:17:08 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:10509 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262935AbREWBQ6>;
	Tue, 22 May 2001 21:16:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105230115.f4N1Flb164635@saturn.cs.uml.edu>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 22 May 2001 21:15:46 -0400 (EDT)
Cc: mingo@elte.hu (Ingo Molnar), viro@math.psu.edu (Alexander Viro),
        rmk@arm.linux.org.uk (Russell King),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        matthew@wil.cx (Matthew Wilcox), alan@lxorguk.ukuu.org.uk (Alan Cox),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105202005070.8426-100000@penguin.transmeta.com> from "Linus Torvalds" at May 20, 2001 08:12:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The problem is that if you expect to get nice code, you have to have nice
> interfaces and infratructure. And ioctl's aren't it.
...
> But that absolutely _requires_ that the driver writers should never see
> the silly "pass a random number and a random argument type" kind of
> interface with no structure or infrastructure in place.
>
> Because right now even _good_ programmers make a mess of the fact that
> they get passed a bad interface.
>
> Think of it this way: the user interface to opening a file is
> "open()" with pathnames and magic flags. But a filesystem never even
> _sees_ that interface, it sees a very nicely structured setup where all
> the argument parsing and locking has already been done for it, and the
> magic flags don't even exist any more as far as the low-level FS is
> concerned. Which is why filesystems _can_ be clean.
>
> In contrast, ioctl's are passed through directly, with no help to make
> them clean.

You want a well-defined interface, allowing over-network use?
Well, here you go, the CORBA ORB patch for Linux 2.4 kernels:
http://korbit.sourceforge.net/

Do you want that against 2.4.5-pre5 or what? Plain ASCII email?

:-)

The really sick thing is that I could actually use this too.
It handles the DSP problem well.


