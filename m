Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVCFOej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVCFOej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVCFOei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:34:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4798 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261405AbVCFOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:34:24 -0500
Date: Sun, 6 Mar 2005 06:44:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050306094451.GA21907@logos.cnet>
References: <20050304222146.GA1686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304222146.GA1686@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:
> Anything else anyone can think of?  Any objections to any of these?
> I based them off of Linus's original list.
> 
> thanks,
> 
> greg k-h
> 
> ------
> 
> Rules on what kind of patches are accepted, and what ones are not, into
> the "linux-release" tree.
> 
>  - It can not bigger than 100 lines, with context.
>  - It must fix only one thing.
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing.)
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue. 

"and breakage of previously working functionality" ? 

>  - No "theoretical race condition" issues, unless an explanation of how
>    the race can be exploited.
>  - It can not contain any "trivial" fixes in it (spelling changes,
>    whitespace cleanups, etc.)
