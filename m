Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTJJQU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTJJQU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:20:28 -0400
Received: from pat.uio.no ([129.240.130.16]:49846 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263036AbTJJQUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:20:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.56385.45369.538978@charged.uio.no>
Date: Fri, 10 Oct 2003 12:20:17 -0400
To: shuey@fmepnet.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Misc NFSv4 (was Re: statfs() / statvfs() syscall ballsup...)
In-Reply-To: <200310101055.12626.shuey@fmepnet.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
	<20031010143553.GA28795@mail.shareable.org>
	<16262.53512.249701.158271@charged.uio.no>
	<200310101055.12626.shuey@fmepnet.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Michael Shuey <shuey@fmepnet.org> writes:

     > How about other features?  In particular, do the client/server
     > do authentication (krb5? lipkey/spkm3?), integrity and privacy?

Client side krb5 authentication was added in November last
year. Privacy and integrity are queued but fell afoul of the
code-freeze. I'll bun(d|g)le them into an NFS_ALL after we've tested
them out in the v4 Bakeathon in Austin (so in about a fortnight).

I believe the server support is ready too but hasn't yet been merged
in due to bugs in the upcall mechanism.

     > Also, are any patches on Citi's site useful anymore?  I see
     > patches for 2.6.0-test1, but nothing more recent.  Have they
     > been folded into the main tree?

I'm cherrypicking the relevant bugfixes from CITI and folding those
into the tree. Much of the rest will be part of the forthcoming
NFS_ALL.

Cheers,
  Trond
