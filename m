Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWHIXFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWHIXFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWHIXFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:05:25 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42880 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751430AbWHIXFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:05:24 -0400
Date: Wed, 9 Aug 2006 16:05:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Pavel Machek <pavel@suse.cz>, Josh Boyer <jwboyer@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060809230506.GF11244@sequoia.sous-sol.org>
References: <200608091749_MC3-1-C796-5E8D@compuserve.com> <20060809220048.GE3691@stusta.de> <20060809221854.GA15395@kroah.com> <20060809224529.GH3691@stusta.de> <20060809225326.GA18560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809225326.GA18560@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Thu, Aug 10, 2006 at 12:45:29AM +0200, Adrian Bunk wrote:
> > > No, I would not use the main git tree to queue patches up.  What happens
> > > when you want to rip the middle one out because in review it turns out
> > > that it is incorrect?
> > 
> >   git-revert
> 
> Ok, fair enough, but it messes with the changelogs a bunch.

You can always keep it all on a "pending" branch, and cherrypick if
needed (instead of straight merge if you needed to drop something) to
keep the final changelogs sane.

thanks,
-chris
