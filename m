Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUJHSas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUJHSas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUJHSal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:30:41 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:4108 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261405AbUJHS2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:28:36 -0400
Date: Fri, 8 Oct 2004 13:26:03 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.28-pre3] 3c59x: resync with 2.6
Message-ID: <20041008132603.G14378@tuxdriver.com>
Mail-Followup-To: Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
	jgarzik@pobox.com, marcelo.tosatti@cyclades.com
References: <20041008121307.C14378@tuxdriver.com> <20041008191324.J17999@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041008191324.J17999@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Oct 08, 2004 at 07:13:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 07:13:24PM +0100, Russell King wrote:
> On Fri, Oct 08, 2004 at 12:13:07PM -0400, John W. Linville wrote:
> > Backport of current 3c59x driver (minus EISA/sysfs stuff) from 2.6 to
> > 2.4.  This should ease further maintenance in 2.4.
> > ---
> > I've been chasing some 3c59x driver problems on both 2.4.x and 2.6.x
> > kernels.  The 3c59x driver was pretty far out of sync between the two
> > trees, so I thought it made sense to sync them back up.
> 
> Ah, if someone's looking at the 3c59x driver then please look into the
> NWAY autonegotiation code - even maybe update it to use mii.c.

Russell,

If you can help to get my patches applied, then I'll be happy to look at
this for you... :-)

BTW, does this sound like the same issue:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=75813

John
-- 
John W. Linville
linville@tuxdriver.com
