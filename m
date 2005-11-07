Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965589AbVKGXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589AbVKGXPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965590AbVKGXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:15:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965589AbVKGXPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:15:47 -0500
Date: Mon, 7 Nov 2005 23:15:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@redhat.com, than@redhat.com
Subject: Re: [PATCH 1/1] My tools break here
Message-ID: <20051107231536.GC11233@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Zachary Amsden <zach@vmware.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@redhat.com, than@redhat.com
References: <200511072156.jA7LuQKv009711@zach-dev.vmware.com> <20051107225024.GB10492@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107225024.GB10492@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:50:24PM +0100, Sam Ravnborg wrote:
> On Mon, Nov 07, 2005 at 01:56:26PM -0800, Zachary Amsden wrote:
> > I have to revert the recent addition of -imacros to the Makefile to get my
> > tool chain to build.  Without the change, below, I get:
> > 
> > Note that this looks entirely like a toolchain bug.
> Then fix your toolchain instead of reverting the -imacros patch.
> 
> The change has been in -git for a full day and in latest -mm too.
> And so far this is the only report that it breaks - I no one else
> complains it will stay.

If more people run into this problem, maybe we should switch to using
-include instead (Zachary indicates that this also fixes the problem.)

Let's try not to throw the preverbial baby out with the bath water.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
