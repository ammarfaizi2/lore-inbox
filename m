Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbSIXPCy>; Tue, 24 Sep 2002 11:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSIXPCy>; Tue, 24 Sep 2002 11:02:54 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:41360 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S261692AbSIXPCx>;
	Tue, 24 Sep 2002 11:02:53 -0400
Message-Id: <200209241519.g8OFJcB26734@www.veltzer.org>
Content-Type: text/plain; charset=US-ASCII
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: Peter Svensson <petersv@psv.nu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
Date: Tue, 24 Sep 2002 18:19:35 +0300
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0209241646170.2383-100000@cheetah.psv.nu>
In-Reply-To: <Pine.LNX.4.44.0209241646170.2383-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 24 September 2002 17:50, Peter Svensson wrote:
> Either you need to educate your users and trust them to
> behave, or you need per user scheduling.

It is obvious that in high end systems you MUST have per user scheduling 
since users will rob each other of cycles.... If Linux is to be a general 
purpose operation system it MUST have this feature (otherwise it will only be 
considered fit for lower end systems) and trusting your users at this no 
better than trusting your users when they promise you they will not seg fault 
or peek into memory pages which are not theirs. It simply isn't done. 
Besides, using the CPU in an abusive manner could happen as a result of a bug 
as much as a result of malicious intent (exactly like a segfault).

Ok. Here's an idea. Why not have both ?!?

There is no real reason why I should have per user scheduling on my machine 
at home (I don't really need a just devision of labour between the root user 
and myself which are almost the only users to use my system). Why not have 
the deault compilation of the kernel be without per user scheduling and 
enable it for high end systems (like a university machine where all the 
students are at each others throats for a few CPU cycles...) ? So how about 
making this a compile option and let the users decide what they like ?

Mark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kIKHxlxDIcceXTgRAjGTAJ9bj1t2QV3zaDheO3GQpvJxxjDSIQCggESi
yqE29XtjTL3VDBu15VTQ0Qc=
=oueS
-----END PGP SIGNATURE-----
