Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbTELMwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTELMwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:52:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26893 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261497AbTELMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:52:41 -0400
Date: Mon, 12 May 2003 15:05:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32: kill code duplication (sparc64 tester wanted)
Message-ID: <20030512130518.GA15227@atrey.karlin.mff.cuni.cz>
References: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz> <20030512134353.A28931@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512134353.A28931@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Attached patch shares ioctl32 handles between x86-64 and sparc64 (and
> > it should be possible/easy to share with other archs, too).
> > 
> > I'd like sparc64 person to test/comment on it...
> 
> I don't have a sparc64, but there's certainly no <asm/mtrr.h> for
> > that arch..

I thought I killed that one?

> Also #including c files is ugly as hell.  What's the #ifdef INCLUDES
> supposed to help?

Yes, but do you have better proposal how to kill 4000+ lines of code
from each 64-bit architecture?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
