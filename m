Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVCXVdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVCXVdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVCXVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:33:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:46314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261560AbVCXVdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:33:21 -0500
Date: Thu, 24 Mar 2005 13:33:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Jan Kara <jack@suse.cz>,
       Mark Wong <markw@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       stable@kernel.org
Subject: Re: ext3 journalling BUG on full filesystem
Message-ID: <20050324213302.GJ28536@shell0.pdx.osdl.net>
References: <20050323202130.GA30844@osdl.org> <20050323221753.GA6334@cse.unsw.EDU.AU> <20050324103945.GF19394@atrey.karlin.mff.cuni.cz> <1111691379.1995.91.camel@sisko.sctweedie.blueyonder.co.uk> <20050324193834.GH28536@shell0.pdx.osdl.net> <1111699467.1995.94.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111699467.1995.94.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen C. Tweedie (sct@redhat.com) wrote:
> On Thu, 2005-03-24 at 19:38, Chris Wright wrote:
> 
> > OK, good to know.  When I last checked you were working on a higher risk
> > yet more complete fix, and I thought we'd wait for that one to stabilize.
> > Looks like the one Jan attached is the better -stable candidate?
> 
> Definitely; it's the one I gave akpm.  The lock reworking is going to
> remove one layer of locks, so it's worthwhile from that point of view;
> but it's longer-term, and I don't know for sure of any paths to chaos
> with that simpler journal_unmap_buffer() fix in place.  (It's just very
> hard to _prove_ all cases are correct without the locking rework.)

Great, I'll add to -stable queue.  Thanks Stephen.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
