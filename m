Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVCFAKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVCFAKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVCFAHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:07:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32653 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261242AbVCFAEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:04:10 -0500
Date: Sun, 6 Mar 2005 00:04:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <ttb@tentacle.dhs.org>, torvalds@osdl.org
Subject: Re: [patch] inotify for 2.6.11
Message-ID: <20050306000409.GD31261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John McCutchan <ttb@tentacle.dhs.org>, torvalds@osdl.org
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109961444.10313.13.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:37:24PM -0500, Robert Love wrote:
> Below is inotify, diffed against 2.6.11.
> 
> I greatly reworked much of the data structures and their interactions,
> to lay the groundwork for sanitizing the locking.  I then, I hope,
> sanitized the locking.  It looks right, I am happy.  Comments welcome.
> I surely could of missed something.  Maybe even something big.
> 
> But, regardless, this release is a huge jump from the previous, fixing
> all known issues and greatly improving the locking.
>

The user interface is still bogus.  Also now version of it has stayed in
-mm long enough because bad bugs pop up almost weekly.

