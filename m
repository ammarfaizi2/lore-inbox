Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTLJWnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTLJWnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:43:21 -0500
Received: from bay7-dav22.bay7.hotmail.com ([64.4.10.79]:57098 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264151AbTLJWnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:43:15 -0500
X-Originating-IP: [24.61.138.136]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "Andre Hedrick" <andre@linux-ide.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "Hua Zhong" <hzhong@cisco.com>, "'Arjan van de Ven'" <arjanv@redhat.com>,
       <Valdis.Kletnieks@vt.edu>,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10312101109380.3805-100000@master.linux-ide.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Wed, 10 Dec 2003 17:43:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV22X5pJQqIVp000081d4@hotmail.com>
X-OriginalArrivalTime: 10 Dec 2003 22:43:14.0294 (UTC) FILETIME=[FF0E4960:01C3BF6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Andre Hedrick" wrote:

> How can the additional words alter the mean of GPL itself?

Because if the additional words in the license predate the publishing date
of the code, they form a valid part of the license for that code as
published.


So the answer to whether such a clause in valid and enforceable (rather than
just Linus' opinion) depends on when any particular piece of code was first
submitted publicly into the kernel tree, who the copyright holder is
(usually the author) and hence which license prevailed at the time the code
was first published.

Later changes to a license are not retroactive to earlier publications
unless the original copyright holder agrees - as only the copyright holder
can change the terms of any license after publication.

The readme for Linux version 0.1 had the copyright owned by Linus and was
not licensed under GPL at all:

"
This kernel is (C) 1991 Linus Torvalds, but all or part of it may be
redistributed provided you do the following:

	- Full source must be available (and free), if not with the
	  distribution then at least on asking for it.

	- Copyright notices must be intact. (In fact, if you distribute
	  only parts of it you may have to add copyrights, as there aren't
	  (C)'s in all files.) Small partial excerpts may be copied
	  without bothering with copyrights.

	- You may not distibute this for a fee, not even "handling" costs.
"

This changed in Version 0.12 with the following statement of intent:

"
The Linux copyright will change: I've had a couple of requests to make
it compatible with the GNU copyleft, removing the "you may not
distribute it for money" condition.  I agree.  I propose that the
copyright be changed so that it confirms to GNU - pending approval of
the persons who have helped write code.  I assume this is going to be no
problem for anybody: If you have grievances ("I wrote that code assuming
the copyright would stay the same") mail me.  Otherwise The GNU copyleft
takes effect as of the first of February.  If you do not know the gist
of the GNU copyright - read it.
"

The next major release was v0.95 in March 1992 which contained a reference
to GPL with this clarification:

"
NOTE! The linux unistd library-functions (the low-level interface to
linux: system calls etc) are excempt from the copyright - you may use
them as you wish, and using those in your binary files won't mean that
your files are automatically under the GNU copyleft.  This concerns
/only/ the unistd-library and those (few) other library functions I have
written: most of the rest of the library has it's own copyrights (or is
public domain).  See the library sources for details of those.
"

For release 0.99 the clarification was missing, with just a standard GPL V2
being used for releases up to 0.99.11 when the (in)famous disclaimer about
user programs was added:

"
 NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".
 Also note that the GPL below is copyrighted by the Free Software
 Foundation, but the instance of code that it refers to (the linux
 kernel) is copyrighted by me and others who actually wrote it.

   Linus Torvalds
"

and then it stayed constant until 2.4 when the GPL V2-only clause was added:

"
 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ license (ie v2), unless explicitly otherwise
 stated.

"


