Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbUKVAGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbUKVAGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUKVAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:04:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261893AbUKVAEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:04:20 -0500
Date: Mon, 22 Nov 2004 00:04:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Message-ID: <20041122000413.A27572@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Antonino Daplas <adaplas@pol.net>,
	linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk> <20041121205613.GA12634@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041121205613.GA12634@infradead.org>; from hch@infradead.org on Sun, Nov 21, 2004 at 08:56:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 08:56:13PM +0000, Christoph Hellwig wrote:
> On Sun, Nov 21, 2004 at 08:47:52PM +0000, Russell King wrote:
> > On Sun, Nov 21, 2004 at 04:36:14PM +0100, Adrian Bunk wrote:
> > > The patch below ncludes the following cleanups for 
> > > drivers/video/cyber2000fb.c:
> > > - remove five EXPORT_SYMBOL'ed but completely unused functions
> > > - make some needlessly global code static
> > 
> > These are used by the video capture code which isn't merged, but is
> > used by people.  Rejected.
> 
> If people use the code it should get merged or Adrian has all reasons to
> remove or #if 0 the code.

Sigh, if that's what you want to do and place extra burden on me,
that's fine.  Don't expect me to co-operate with you next time you
want me to do something though, no matter how important you feel it
is.  Works both ways.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
