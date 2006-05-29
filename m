Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWE2B5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWE2B5z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 21:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWE2B5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 21:57:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17552 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751091AbWE2B5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 21:57:54 -0400
Date: Mon, 29 May 2006 11:57:27 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com
Subject: Re: [patch 0/5] [RFC] vfs: per-superblock unused dentries list
Message-ID: <20060529015727.GS8069029@melbourne.sgi.com>
References: <20060526110655.197949000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526110655.197949000@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 01:06:55PM +0200, Jan Blunck wrote:
> BTW: Dave, I just saw that you already posted some patches but I decided to
> send my patches anyway.

No problems. Your patches remove bits that I wasn't sure could be removed,
but effectively do the same thing. Removing shrink_dcache_anon(), for example.
The question is which patchset do we want to carry forward?

I'll add more comments in replies to the various patches...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
