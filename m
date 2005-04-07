Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVDGJ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDGJ4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVDGJ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:56:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26632 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261287AbVDGJzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:55:36 -0400
Date: Thu, 7 Apr 2005 10:55:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-ID: <20050407105531.A19605@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <20050407015019.4563afe0.akpm@osdl.org> <1112865919.24487.442.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1112865919.24487.442.camel@hades.cambridge.redhat.com>; from dwmw2@infradead.org on Thu, Apr 07, 2005 at 10:25:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 10:25:18AM +0100, David Woodhouse wrote:
> On Thu, 2005-04-07 at 01:50 -0700, Andrew Morton wrote:
> > (I don't do that for -mm because -mm basically doesn't work for 99% of
> > the time.  Takes 4-5 hours to out a release out assuming that
> > nothing's busted, and usually something is).
> 
> On the subject of -mm: are you going to keep doing the BK imports to
> that for the time being, or would it be better to leave the BK trees
> alone now and send you individual patches.
> 
> For that matter, will there be a brief amnesty after 2.6.12 where Linus
> will use BK to pull those trees which were waiting for that, or will we
> all need to export from BK manually?

Linus indicated (maybe privately) that the end of his BK usage would
be immediately after the -rc2 release.  I'm taking that to mean "no
more BK usage from Linus, period."

Thinking about it a bit, if you're asking Linus to pull your tree,
Linus would then have to extract the individual change sets as patches
to put into his new fangled patch management system.  Is that a
reasonable expectation?

However, it's ultimately up to Linus to decide. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
