Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157016AbQFTX5d>; Tue, 20 Jun 2000 19:57:33 -0400
Received: by vger.rutgers.edu id <S157014AbQFTXz6>; Tue, 20 Jun 2000 19:55:58 -0400
Received: from mail.via.net ([209.81.9.12]:2232 "EHLO mail.via.net") by vger.rutgers.edu with ESMTP id <S156198AbQFTXy6> convert rfc822-to-8bit; Tue, 20 Jun 2000 19:54:58 -0400
Message-Id: <200006202358.QAA61098@mail.via.net>
Date: Tue, 20 Jun 2000 17:00:17 -0700 (PDT)
From: "Jason T. Collins" <jcollins@valinux.com>
Subject: VA 'Cerberus' test suite release 1.2.1
To: linux-kernel@vger.rutgers.edu
X-Mailer: Mahogany, 0.50 'Meadows' , compiled for Linux 2.2.14jtc2 i686
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: INLINE
Sender: owner-linux-kernel@vger.rutgers.edu

Hi all,

I've recently uploaded version 1.2.1 of VA-CTCS, VA's test suite for
stressing hardware, to the locations mentioned at the bottom of this
e-mail.  Please read README.FIRST if you are not familiar with this
software -- this system loader has been known to damage marginal hardware,
including catching system power supplies *ON FIRE*, and neither VA Linux
Systems nor myself will be responsible for any damage caused.

What's new in this version since 1.1.7?  Here is a summary:
- Lazy Developer Installation method:
	tar -zvxf ctcs-1.2.1.tar.gz
	cd ctcs-1.2.1
	./newburn
	-- and CTCS takes care of compiling itself and checking your system
	for required binaries, etc.
- Many new modules:
	Included in VA-CTCS is Robert Redelmeier's CPU/Memory stress
	testers, the BYTE benchmarking suite, crashme, as well as some
	new VA authored modules (such as the Fast kernel-compile test)
- New command line options to "newburn" with -h to get help.
- Enhanced memory tester checks for error consistency and provides context
  for memory failures.
- More compatibility with non-Red Hat distributions and the 2.4 kernel
series.
- Some work started to make CTCS more friendly to non-x86 platforms, but
there are still issues.

What is VA-CTCS?

VA-CTCS consists of a test iterator, a collection of test modules, and a
test generator.  The main test program, "newburn", detects your hardware
and comes up with a custom combination of tests designed to beat on your
system and its peripherals, modified by your parameters.  VA
Linux Systems has released VA-CTCS under the GPL.

Why is VA-CTCS useful for kernel developers?

CTCS is useful for:
	- Use as a generic system loader
	- Iterating your own test code and recording failure data for you
	  while you concentrate on debugging
	- Bashing at the filesystem/buffer cache layer with the data and
	  block test modules
	- and much more..

If you've ever spent a lot of time scripting tests to report time to
failure, number of iterations, record all of it to a synchronous logfile,
etc, you'll find CTCS to be handy.  Besides, as you know, when a system is
thrashing lots of obscure problems can come out of the woodwork..

Where is VA-CTCS?

VA-CTCS has a SourceForge project:
https://sourceforge.net/project/?group_id=5317

The latest version is available via FTP:
ftp://ftp.valinux.com/pub/software/Cerberus/ctcs-1.2.1.tar.gz

--
Jason T. Collins
Software Engineer
VA Linux Systems




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
