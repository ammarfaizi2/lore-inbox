Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVCEN7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVCEN7s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 08:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVCEN7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 08:59:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24836 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261378AbVCEN7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 08:59:18 -0500
Date: Sat, 5 Mar 2005 14:59:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050305135917.GB6373@stusta.de>
References: <20050304222146.GA1686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304222146.GA1686@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:

> Anything else anyone can think of?  Any objections to any of these?
> I based them off of Linus's original list.

Are these 100% fixed rules or just guidelines you use?

An example that doesn't fit:

A patch of me to remove an unused function was accepted into 2.6.11 .
Today, someone mailed that there's an external GPL'ed module that uses 
this function.

A patch to re-add this function as it was in 2.6.10 does not fulfill 
your criteria, but it is a low-risk way to fix a regression compared to 
2.6.10 .

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
>  - No "theoretical race condition" issues, unless an explanation of how
>    the race can be exploited.
>  - It can not contain any "trivial" fixes in it (spelling changes,
>    whitespace cleanups, etc.)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

