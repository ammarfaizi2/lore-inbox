Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWBKI4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWBKI4K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 03:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWBKI4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 03:56:09 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:63684 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S1751251AbWBKI4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 03:56:08 -0500
Date: Sat, 11 Feb 2006 16:55:49 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Userland Suspend Devel <suspend-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060211085549.GG8154@blackham.com.au>
References: <200602030918.07006.nigel@suspend2.net> <200602100007.10233.rjw@sisk.pl> <20060209231459.GA3389@elf.ucw.cz> <200602100035.04969.rjw@sisk.pl> <20060210002406.GF8154@blackham.com.au> <20060210003533.GJ3389@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210003533.GJ3389@elf.ucw.cz>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 01:35:33AM +0100, Pavel Machek wrote:
> > On Fri, Feb 10, 2006 at 12:35:04AM +0100, Rafael J. Wysocki wrote:
> > > Now, the question is do we chroot or not?
> > 
> > What's wrong with setrlimit(RLIMIT_NOFILE, 0) (and RLIMIT_CORE). So
> > long as you open all your necessary device nodes before doing so.
> 
> Nothing, but we got chroot idea, first.

Kinda like suspend2 didn't get into the kernel first?

I still think you're reinventing the wheel, and making it triangular :(
I don't understand your motivations for moving something that is so
intimately tied to the running kernel itself into userspace. A mouse
driver, sure. But the more I think about it, the more it seems nuts to me.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
