Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUDBXSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUDBXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:18:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:43459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbUDBXSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:18:30 -0500
Date: Fri, 2 Apr 2004 15:18:28 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402151828.I21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040402133540.1dfa0256.akpm@osdl.org> <20040402143639.G21045@build.pdx.osdl.net> <20040402150152.7675cf7e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402150152.7675cf7e.akpm@osdl.org>; from akpm@osdl.org on Fri, Apr 02, 2004 at 03:01:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> http://www.zip.com.au/~akpm/linux/patches/stuff/pam_cap-akpm.tar.gz

Cool, thanks.

> That's my point, Chris.  "the feature is bollixed, so let's write a ton of
> new parallel stuff but not fix the original code".  This is how cruft
> accumulates.

Yes, OK, point well-taken.

> > Our goal was actually to keep is compatible.  All of it's limitations
> > predate the security stuff.
> 
> Either the fine-grained capabilities are fixable, or they should be deleted
> and we go back to suser().  One of those things should have happened before
> adding more code, surely?

I s'pose we rather viewed the behaviour as legacy...stuck with, don't
muck with...Making it usable is certainly better than going back to
suser(), so let's procede that way and reconcile the mistake.

> > IIRC, changing those (existing) securebits settings creates an unusable
> > machine.  Again, I think there was some anticipation of the fs bits
> > going in later.  Perhaps those securebits pieces could just be removed.
> 
> OK.  Do you have time to do the honours?

Sure thing.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
