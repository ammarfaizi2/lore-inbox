Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSDDXql>; Thu, 4 Apr 2002 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312076AbSDDXqb>; Thu, 4 Apr 2002 18:46:31 -0500
Received: from ppp-228-11.25-151.libero.it ([151.25.11.228]:14580 "EHLO
	ashland") by vger.kernel.org with ESMTP id <S312031AbSDDXqT>;
	Thu, 4 Apr 2002 18:46:19 -0500
To: linux-kernel@vger.kernel.org
Subject: forth interpreter as kernel module
From: davidw@dedasys.com (David N. Welton)
Date: 05 Apr 2002 01:49:03 +0200
Message-ID: <877knnowi8.fsf@dedasys.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ please CC replies to me ]

Hello,

Once upon a time, I had a rather random idea, and, acting on it, I
wedged a forth interpreter into the Linux kernel.  I've always wanted
to clean it up and do things nicely, but have never really found the
time or the motivation.

So, I am posting here, in the hope that someone might find the idea
interesting and take it up, or, better yet, think of something that it
might actually be used for (this was besides the point when I did it).

I doubt the code itself is of much interest.  Actually, I'm pretty
embarassed about it, but decided to make it available despite that.

It does run, on my system (2.4.18):

@grantspass [/home/davidw/workshop/pforth-21] # insmod kpforth.o 
Warning: loading kpforth.o will taint the kernel: no license

@grantspass [/proc] # echo 3 . > kpforth
@grantspass [/proc] # cat kpforth-out 
pfLoadDictionary - Filename ignored! Loading from static data.
Static data copied to newly allocated dictionaries.
Begin AUTO.INIT ------
3    ok
Stack<10> 

Although from what I recall when experimenting with it, there are some
definite 'issues'.  See aforementioned disclaimer about the code.  It
doesn't interface with the kernel in any interesting ways, either.

Anyway, for the interested/bored/adventerous, the code may be found
at:

http://www.dedasys.com/freesoftware/files/kpforth-21.tgz

The original forth system that I based it on - pforth - which is much
better code then mine, is by Phil Burk.

I would be interested in comments on what should be fixed in the code,
although I may not have time to act on them.

Anyway, hope this is of interest to someone, and thank you for your
time,
-- 
David N. Welton
   Consulting: http://www.dedasys.com/
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
