Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbVCXTkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbVCXTkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVCXTjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:39:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:47291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262656AbVCXTis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:38:48 -0500
Date: Thu, 24 Mar 2005 11:38:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Mark Wong <markw@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: ext3 journalling BUG on full filesystem
Message-ID: <20050324193834.GH28536@shell0.pdx.osdl.net>
References: <20050323202130.GA30844@osdl.org> <20050323221753.GA6334@cse.unsw.EDU.AU> <20050324103945.GF19394@atrey.karlin.mff.cuni.cz> <1111691379.1995.91.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111691379.1995.91.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen C. Tweedie (sct@redhat.com) wrote:
> Hi,
> 
> On Thu, 2005-03-24 at 10:39, Jan Kara wrote:
> 
> >   Actually the patch you atached showed in the end as not covering all
> > the cases and so Stephen agreed to stay with the first try (attached)
> > which should cover all known cases (although it's not so nice).
> 
> Right.  The later patch is getting reworked into a proper locking
> overhaul for the journal_put_journal_head() code.  The earlier one (that
> Jan attached) is the one that's appropriate in the mean time; it covers
> all of the holes we know about for sure and has proven robust in
> testing.

OK, good to know.  When I last checked you were working on a higher risk
yet more complete fix, and I thought we'd wait for that one to stabilize.
Looks like the one Jan attached is the better -stable candidate?

thanks,
-chris
