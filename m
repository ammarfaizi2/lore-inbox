Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTJPIUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTJPIUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:20:08 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:61068 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262765AbTJPIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:20:05 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031015162056.018737f1.akpm@osdl.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
	 <20031015162056.018737f1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1066292352.661.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 16 Oct 2003 10:19:12 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 01:20, Andrew Morton wrote:
> James Simmons <jsimmons@infradead.org> wrote:
> >
> > Here is the latest fbdev patches.
> 
> This one comes up again and again.  What should we do with it?

The fix is wrong for accelerated displays.

rinfo->pitch should be initialized previously, but then, I'm not sure
what version of radeonfb James actually has in his tree. I'm mostly
rewriting it now, though my "new" version hasn't been submited yet,
it's definitely not ready.

I could eventually submit an updated "old" version though...

Ben.

