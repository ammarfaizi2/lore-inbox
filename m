Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWH1Utp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWH1Utp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWH1Uto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:49:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWH1Uto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:49:44 -0400
Date: Mon, 28 Aug 2006 13:49:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-mm@kvack.org, "LKML" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Val Henson <val.henson@intel.com>
Subject: Re: [PATCH RFP-V4 00/13] remap_file_pages protection support - 4th
 attempt
Message-Id: <20060828134915.f7787422.akpm@osdl.org>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 19:33:35 +0200
Blaisorblade <blaisorblade@yahoo.it> wrote:

> Again, about 4 month since last time (for lack of time) I'm sending for final 
> review and for inclusion into -mm protection support for remap_file_pages (in 
> short "RFP prot support"), i.e. setting per-pte protections (beyond file 
> offset) through this syscall.

This all looks a bit too fresh and TODO-infested for me to put it in -mm at
this time.

I could toss them in to get some testing underway, but that makes life
complex for other ongoing MM work.  (And there's a _lot_ of that - I
presently have >180 separate patches which alter ./mm/*).

Also, it looks like another round of detailed review is needed before this
work will really start to settle into its final form.

So..   I'll await version 5, sorry.   Please persist.
