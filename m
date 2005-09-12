Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVILDRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVILDRd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 23:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVILDRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 23:17:33 -0400
Received: from thunk.org ([69.25.196.29]:7630 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751139AbVILDRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 23:17:33 -0400
Date: Sun, 11 Sep 2005 23:16:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       "Bharata B. Rao" <bharata@in.ibm.com>
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050912031636.GB16758@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, "Bharata B. Rao" <bharata@in.ibm.com>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911120045.GA4477@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 05:30:46PM +0530, Dipankar Sarma wrote:
> Do you have the /proc/sys/fs/dentry-state output when such lowmem
> shortage happens ?

Not yet, but the situation occurs on my laptop about 2 or 3 times
(when I'm not travelling and so it doesn't get rebooted).  So
reproducing it isn't utterly trivial, but it's does happen often
enough that it should be possible to get the necessary data.

> This is a problem that Bharata has been investigating at the moment.
> But he hasn't seen anything that can't be cured by a small memory
> pressure - IOW, dentries do get freed under memory pressure. So
> your case might be very useful. Bharata is maintaing an instrumentation
> patch to collect more information and an alternative dentry aging patch 
> (using rbtree). Perhaps you could try with those.

Send it to me, and I'd be happy to try either the instrumentation
patch or the dentry aging patch.

Thanks, regards,

							- Ted
