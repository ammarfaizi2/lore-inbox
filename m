Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272163AbTHIBFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272167AbTHIBFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:05:01 -0400
Received: from pat.uio.no ([129.240.130.16]:33431 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S272163AbTHIBEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:04:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16180.18582.867761.522912@charged.uio.no>
Date: Sat, 9 Aug 2003 03:04:22 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Timothy Miller <miller@techsource.com>, Jasper Spaans <jasper@vs19.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
In-Reply-To: <Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org>
References: <shsisp7fzkg.fsf@charged.uio.no>
	<Pine.LNX.4.44.0308081738380.3739-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

     > On 9 Aug 2003, Trond Myklebust wrote:
    >>
    >> Since we appear to be in the silly season...

     > No, your patch isn't silly, it's EVIL. It fundamentally breaks
     > the notion of "grep for usage" by introducing two names to the
     > same thing, without having even a good reason (ie no "nice
     > abstraction" thing or anything).

Right! I fully agree that having 2 names for the same type is bad,
although "find -type f | grep flavou?r" would be a quite adequate way
of matching both spellings.

The point is, though, that I could have written

rpc_authflavor_t f;

and nobody would have cared or complained about grepability.

Anybody who claims that they have problems reading the code due to the
difference between US and British spelling of the same variable is in
reality engaged in a completely different type of crusade. One that
doesn't deserve attention...

Cheers,
  Trond
