Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCCTis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCCTis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVCCTf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:35:59 -0500
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:16297 "HELO
	web31506.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261582AbVCCSyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:54:21 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=fyU7lTFFI9Q5fWRY3eGqOat8Cq80bVna1VWjbXQq/L9Qg3x9N7aGBJXg9PybYuGQkTR0C6humMAyOWvAW73Bv0Eh4rkAlnPCck82bpaNcmB0qCy4cKbAwKpJ66O7w5YLoWmGdN7HjZFoclmwxX9HimApAV1+ASfLz/mz4CmXAnc=  ;
Message-ID: <20050303185420.59785.qmail@web31506.mail.mud.yahoo.com>
Date: Thu, 3 Mar 2005 10:54:20 -0800 (PST)
From: Jonathan Day <imipak@yahoo.com>
Subject: Another way to resolve numbering issues
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I like the rapid cycling that Linux has switched to,
but I also like to know how stable something is. At
first sight, it's not obvious you can have both,
without the split trees that were causing headaches.

However, there may be an alternative, if there's any
agreement on testing. (There are validation suites and
validating compilers out there - earlier kernels went
through many a cycle of Stanford's compiler, if I
recall correctly.)

The suggestion is to put indicators of confidence in
the EXTRAS field for the kernel name. As an example,
let's say that kernel 2.6.15 is shown to be 75% clean
of likely problems, as a whole, but that there's a
variance of 10% from this mean value, when looking at
the individual modules. You really want a high value
to mean lots of confidence, so you actually want the
lack of variance, which is 100-10=90 in this case.

Your version number would then be: 2.6.15.75.90

That way, it doesn't matter if odd or even were
"stable", because you have a good idea of what the
stability is from those last two components. It also
cuts down on Linus' collection of Brown Paper Bags,
which will likely improve his family life.

Of course, there are no "simple" solutions, and this
is no exception. Sure, there are test suites and
validators, but what you'd need is a test suite or
validator that kernel developers as a whole would find
plausible, that can be updated fast enough to keep up
with the kernel changes and where the maintainers are
capable of learning enough about the different areas
to write tests that are even sensible. Because Linux
is written by coders (for the most part), such a
testing suite would also have to be simple enough,
fast enough and unobtrusive enough that coders would
actually use it.

IBM and SGI are involved in the Linux Testing Project,
and IBM has done a fair bit with getting SuSE through
the various EAL certifications, if rumors are to be
believed. Stanford has the validating compiler, as
I've mentioned. Assuming that the above concept isn't
shot down, disemboweled and fed to a cannibalistic
text editor, some combination of Linux hackers and the
above groups should be able to put together something
that would help identify if a kernel is stable or not.



	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
