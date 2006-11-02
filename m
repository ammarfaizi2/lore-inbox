Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752526AbWKBUOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbWKBUOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbWKBUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:14:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752526AbWKBUOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:14:17 -0500
Date: Thu, 2 Nov 2006 12:10:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Auke Kok <auke-jan.h.kok@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions
Message-Id: <20061102121027.676db964.akpm@osdl.org>
In-Reply-To: <200611022102.02302.rjw@sisk.pl>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061031195654.GV27968@stusta.de>
	<200611022102.02302.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 21:02:01 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> On Tuesday, 31 October 2006 20:56, you wrote:
> > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> > that are not yet fixed in Linus' tree.
> 
> Can we please add the following two to the list of known regressions:

Balls are being dropped.

> http://bugzilla.kernel.org/show_bug.cgi?id=7082

So this was a good patch but because of a bug in ne2k-pci which nobody is
fixing we need to drop it?

> http://bugzilla.kernel.org/show_bug.cgi?id=7207

Auke, Jesse - can you please opine on this?

> They are regressions with respect to 2.6.17.x kernels, but still.
> 
> In both cases the commits that cause or trigger the problem have been
> identified.  Moreover in the first case everyone involved seems to agree that
> the commit should be reverted (at least temporarily).
> 
> Greetings,
> Rafael
