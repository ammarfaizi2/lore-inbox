Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTDGItw (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTDGItw (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:49:52 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:33492 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263349AbTDGItq (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:49:46 -0400
Subject: Re: 2.5: NFS troubles
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1049675270.753.166.camel@localhost>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	 <shsbrzjn5of.fsf@charged.uio.no>  <20030406171855.6bd3552d.akpm@digeo.com>
	 <1049675270.753.166.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1049706067.592.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 11:01:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 02:27, Robert Love wrote:
> On Sun, 2003-04-06 at 20:18, Andrew Morton wrote:
> 
> > if it shows dir_index then it might be an ext3 problem.  If not then it is
> > probably an NFS problem.
> 
> Nah, its not an ext3 problem (at least not with htree).

But it could be an interaction problem between NFS and ext3. I did what
Andrew pointed (disabling dir_index) and it solved my problems.

I don't think it's a client problem, since I can't reproduce with
2.4+ext3, 2.5.66+ext2 and 2.5.66+ext3-dir_index, but is reproducible
with 2.5.66+ext3+dir_index.

________________________________________________________________________
Linux Registered User #287198

