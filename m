Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRBVLPb>; Thu, 22 Feb 2001 06:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBVLPV>; Thu, 22 Feb 2001 06:15:21 -0500
Received: from 209.102.21.2 ([209.102.21.2]:55568 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129091AbRBVLPS>;
	Thu, 22 Feb 2001 06:15:18 -0500
Message-ID: <3A94AE02.9ED1C7F6@goingware.com>
Date: Thu, 22 Feb 2001 06:13:22 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Update to kernel test suite article
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I posted the URL in the comments on tonight's Slashdot article on "Making
Software Suck Less", I thought I should incorporate some of the comments people
had made about my article over the past few weeks:

Using Test Suites to Validate the Linux Kernel
http://linuxquality.sunsite.dk/articles/testsuites/index.html

I knew I had a couple HTML errors in it, so I ran it through the W3C validation
service until it came out 4.01-strict clean:

http://validator.w3.org/

Try the validator on your own pages, it's pretty embarrassing what it can find. 
On an old page of mine I'd accidentally copied and pasted a whole repetition of
the <body></body> tags and all the text in between at the end of the file - but
it didn't show up in any browser.

I added these tests:

- PostgreSQL's regression tests
- Mauve
- VA Linux Cerberus
- cpuburn
- Lucifer

the last three are hardware stress tests and should be used with caution, and
probably not on a machine you would be concerned about setting on fire.

There are a few more suites to be added that I need to dig out of my email.

Fortuitously, while I was editing the new draft, a helpful fellow from IBM
Israel named Michael Veksler wrote in with some suggestions for improvement of
some really bad grammar errors I'd committed, and a suggestion that I add some
comments about test coverage - making sure that all components of the kernel get
tested by some test or other.  I've taken his grammar suggestions but still need
to write about the test coverage.

I'm going to write on article on web application testing next.  Besides
discussing the W3C validation service, I'll also talk about load generators for
web servers.  A recent client of mine could have avoided hiring me at all if
he'd gone to http://freshmeat.net and entered the word "stress" into the search
box.

Regards,

Mike Crawford
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
