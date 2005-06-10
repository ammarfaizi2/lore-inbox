Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVFJPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVFJPWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVFJPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:22:09 -0400
Received: from imap.mtholyoke.edu ([138.110.1.185]:51149 "EHLO
	mist.mtholyoke.edu") by vger.kernel.org with ESMTP id S261847AbVFJPWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:22:03 -0400
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Fri, 10 Jun 2005 11:21:54 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: slow directory listing
Message-ID: <20050610152154.GB14454@mtholyoke.edu>
References: <20050610143720.GA14454@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610143720.GA14454@mtholyoke.edu>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 10:37:20AM -0400, rpeterso wrote:

> I'm setting up a new mail server, and am testing/tweaking IO.  I have
> two directories: /test/a which contains 750 mbox files totalling 8GB,
> and /test/a2, which contains the exact same number of files, same names,
> all zero length.
> ...
> The times taken to do a directory listing are significantly different.

I've become more confused, if that's possible.  I was just editing some
test script in emacs.  As part of the script creation process I used the
M-! command to pipe the output of 'ls /test/a' into a buffer.  It
snapped back almost instantly.

So this seems to have something to do w/ bash, not filesystems.  I
think.  So seems OT for this list, but I still don't understand where
the sluggishness comes from.

BTW, I just did the same test w/ XFS and the results were almost
identical.

Best.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
