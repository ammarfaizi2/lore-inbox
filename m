Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTDGVsn (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbTDGVsn (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:48:43 -0400
Received: from pat.uio.no ([129.240.130.16]:65432 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263705AbTDGVsG (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:48:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.62619.296543.371236@charged.uio.no>
Date: Mon, 7 Apr 2003 23:58:51 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, rml@tech9.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: NFS troubles
In-Reply-To: <1049707384.592.19.camel@teapot.felipe-alfaro.com>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	<shsbrzjn5of.fsf@charged.uio.no>
	<20030406171855.6bd3552d.akpm@digeo.com>
	<1049675270.753.166.camel@localhost>
	<1049706067.592.5.camel@teapot.felipe-alfaro.com>
	<20030407021331.1ffbfa7f.akpm@digeo.com>
	<1049707384.592.19.camel@teapot.felipe-alfaro.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:


    >> If Robert is seeing it on non-htree servers then we'd need to
    >> see that fixed up before deciding if there is also an(other)
    >> htree bug.

     > I sent a tcpdump and strace as attachments in my original
     > message ;-) Do you have it handy? Should I send it again?...

Robert was seeing a very different read-related bug (not related to
the htree bug). I posted a fix for it earlier this afternoon, and he
has already confirmed that it fixed his problem.

Cheers,
  Trond
