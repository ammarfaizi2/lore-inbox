Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263630AbTEMLXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 07:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTEMLXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 07:23:36 -0400
Received: from pat.uio.no ([129.240.130.16]:29098 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263630AbTEMLXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 07:23:34 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 May 2003 13:36:14 +0200
In-Reply-To: <20030512155511.21fb1652.akpm@digeo.com>
Message-ID: <shswugvjcy9.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

     > - NFS client gets an OOM deadlock.
     > - Some fixes exist in -mm.  Seem to mostly work.
     > - NFS client runs very slowly consuming 100% CPU under heavy
     >   writeout.
     > - Unsubtle fix exists in -mm.  (Looks like it's fixed anyway).

<snip>

     > - davej: NFS seems to have a really bad time for some people.  (Including
     >   myself on one testbox).  The common factor seems to be a high
     >   spec client torturing an underpowered NFS server with lots of
     >   IO.  (fsx/fsstress etc show this up).  Lots of "NFS server
     >   cheating" messages get dumped, and a whole lot of bogus
     >   packets start appearing.  They look severely corrupted, (they
     >   even crashed ethereal once 8-)

Could people please test these items out again using the latest
Bitkeeper release? I believe I've addressed all these issues with the
patches that have gone to Linus in the last 2-3 weeks.

Cheers,
  Trond
