Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVDFCJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVDFCJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVDFCJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:09:36 -0400
Received: from waste.org ([216.27.176.166]:58810 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262076AbVDFCJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:09:34 -0400
Date: Tue, 5 Apr 2005 19:09:29 -0700
From: Matt Mackall <mpm@selenic.com>
To: Kenneth Aafl?y <lists@kenneth.aafloy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style: mixed-case
Message-ID: <20050406020929.GJ25554@waste.org>
References: <200504060329.21469.lists@kenneth.aafloy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504060329.21469.lists@kenneth.aafloy.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 03:29:21AM +0200, Kenneth Aafl?y wrote:
> Hi,
> 
> while reading Documentation/CodingStyle for the nth time, I realized that I had
> read some conflicting coding style in some patch posted to the linux-kernel
> mailing-list; in include/linux/page-flags.h, there is a lot of defines that are
> apparently frowned upon:
> 
> HOWEVER, while mixed-case names are frowned upon, descriptive names for
> global variables are a must.  To call a global function "foo" is a
> shooting offense.
> 
> Are those an exception to the rule or would for example
> PF_LOCKED/pf_locked be a nice replacement for PageLocked?

While there may be reasons why mixed case is suboptimal, the real
reason is that it's hard to keep track of which style is used where.
It's annoying and error-prone to have to remember the naming format
for everything in addition to its name. As most things are in a
standard style, things are made easier by having every piece of new
code follow that style and let us slowly approach uniformity.

If you posted a patch for pf_locked() and friends (and note that it's
lowercase to match function-like usage), you'd probably find some
enthusiasts and some naysayers. Most of the naysayers would object on
the grounds of "it ain't broke", but if someone were to do it as part
of a series of more substantial clean-ups, it'd likely be accepted.

-- 
Mathematics is the supreme nostalgia of our time.
