Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWATXzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWATXzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWATXzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:55:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3336 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750727AbWATXzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:55:31 -0500
Date: Fri, 20 Jan 2006 23:55:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Loftis <mloftis@wgops.com>
Cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120235520.GC20148@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Marc Koschewski <marc@osknowledge.org>,
	linux-kernel@vger.kernel.org
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr> <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com> <20060120194331.GA8704@kroah.com> <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com> <20060120231757.GB20148@flint.arm.linux.org.uk> <8ADF978F40BCF69BF8BEC36F@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ADF978F40BCF69BF8BEC36F@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:33:38PM -0700, Michael Loftis wrote:
> As long as it isn't wash rinse repeat, but in development kernels it tends 
> to be.  That's the pain point.  It's not one single huge problem, it's the 
> constant stream of little ones that we try to avoid.

So what you're basically saying is that we should make zero changes
to the kernel, because any change (even a minor bug fix) may cause
you to need to do some work.  Should we just increment the version
number every 3 months then?

Maybe we could do this _if_ folk would stop working on the kernel,
wanting it to run on their latest creations.

The fact is that in the ARM world, everyone wants a stable kernel
which has support for all the features in the SoC de jour that
they're using.  That previous sentence is self-contradictory - it's
an impossible scenario.  You can't have a kernel which supports the
latest features without progressive and continuous change.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
