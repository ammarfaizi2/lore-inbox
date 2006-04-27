Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWD0WOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWD0WOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWD0WOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:14:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751819AbWD0WOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:14:24 -0400
Date: Thu, 27 Apr 2006 15:16:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: gcoady.lk@gmail.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-Id: <20060427151648.1a79b93a.akpm@osdl.org>
In-Reply-To: <20060427145017.f35c906f.rdunlap@xenotime.net>
References: <20060427014141.06b88072.akpm@osdl.org>
	<p73vesv727b.fsf@bragg.suse.de>
	<20060427121930.2c3591e0.akpm@osdl.org>
	<jmd2529m892ln9h8ptpp58ltq5895495nb@4ax.com>
	<20060427145017.f35c906f.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Fri, 28 Apr 2006 07:41:52 +1000 Grant Coady wrote:
> 
> > On Thu, 27 Apr 2006 12:19:30 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > >I don't like dropping patches.  Because then the thing needs to be fixed up
> > >and resent and remerged and re-reviewed and rejects need to re-fixed-up and
> > >this adds emailing overhead and 12-24 hour turnaround, etc.  I very much
> > >prefer to hang onto the patch and get it fixed up.  This means that I
> > >usually have to do the fixing-up.
> > 
> > Perhaps dropping patches with obvious faults with some feedback 
> > to submitter may reduce your workload ;)  And is slowing down the 
> > merge a little in these cases such a bad thing if it improves 
> > patch quality over time?
> 
> True dat.  That's what I would do.  :)

As I say - I prefer to keep moving in the forward direction.  So if a patch
needs coding-style cleanups, warning fixes, bugfixes, etc it's usually
quicker to just fix the thing immediately rather than send it back, wait
and then redo everything.  The submitter sees the fixes and hence will
Never Do That Again (right?)

None of this is a particular burden for me - it'd average an hour a day,
tops.  My main reason for the big whine is that this defect rate indicates
that people just aren't being sufficiently careful in their work.  If so
many silly trivial things are slipping through, then what does this tell us
about the big things, ie: runtime bugs?

> But I seem to need more sleep than Andrew does.

There's plenty of time for that in the grave.
