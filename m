Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbTGUVJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270715AbTGUVJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:09:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58241
	"EHLO x30.random") by vger.kernel.org with ESMTP id S270713AbTGUVJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:09:57 -0400
Date: Mon, 21 Jul 2003 17:21:55 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030721212155.GF4677@x30.linuxsymposium.org>
References: <20030721190226.GA14453@matchmail.com> <20030721194514.GA5803@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721194514.GA5803@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Mon, Jul 21, 2003 at 12:45:14PM -0700, Larry McVoy wrote:
> You don't need the tags, use dates.  You can get the date range you want 
> with an rlog of the ChangeSet file and then use those dates.

I realized I could do this, and it can of course be automated with an
additional bkcvs specific hack in cvsps. But the tag in every file would
have kept the functionality generic with the already available -r
option, and since I can't see any downside in the tag in the files, I
prefer that generic way.

But if you're sure the tags aren't coming back we can start adding the
automation to cvsps.

thanks,

Andrea
