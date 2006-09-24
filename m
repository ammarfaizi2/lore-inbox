Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWIXXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWIXXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWIXXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 19:09:58 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:13328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751347AbWIXXJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 19:09:57 -0400
Date: Mon, 25 Sep 2006 00:09:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sean <seanlkml@sympatico.ca>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060924230948.GG12795@flint.arm.linux.org.uk>
Mail-Followup-To: Sean <seanlkml@sympatico.ca>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, jeff@garzik.org,
	davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com> <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> <20060924074837.GB13487@xi.wantstofly.org> <20060924092010.GC17639@flint.arm.linux.org.uk> <20060924142353.6c725128.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924142353.6c725128.seanlkml@sympatico.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 02:23:53PM -0400, Sean wrote:
> On Sun, 24 Sep 2006 10:20:10 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > The point I'm making is that for some things, keeping the changes as
> > patches until they're ready is far easier, more worthwhile and flexible
> > than having them simmering in some git tree somewhere.
> 
> It's not really easier, just different.   Git allows you to make a 
> "topic branch" to keep separate items that need to bake before going
> upstream without being mixed in with all your other worked.  This
> allows you to continue to pull in upstream changes to make sure that
> the patch series still applies cleanly and doesn't need updates etc.
> 
> Of course you may be more comfortable with other tools, but Git _does_
> make it easy and practical to do the same thing.

Before people disagree with my statement (and I'm referring to all the
replies so far), maybe they should talk to Thomas who pioneered the
genirq changes to find out why he decided to work with patches rather
than a git repository?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
