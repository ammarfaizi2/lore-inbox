Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267575AbUHPMhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267575AbUHPMhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUHPMhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:37:32 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:27141 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267575AbUHPMhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:37:31 -0400
Date: Mon, 16 Aug 2004 13:37:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20040816133728.A10686@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org> <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org> <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org> <1092654719.20523.18.camel@localhost.localdomain> <20040816132022.A10567@infradead.org> <Pine.LNX.4.58.0408161323300.32584@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408161323300.32584@skynet>; from airlied@linux.ie on Mon, Aug 16, 2004 at 01:24:30PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 01:24:30PM +0100, Dave Airlie wrote:
> >
> > Works fine on all my pmacs here.  In fact X works only on fbdev for
> > full features.
> 
> I think Alan would classify that as luck rathar than design... and I would

All the fbdev handling code in X is also an accident?

Really, why do you even push for this change if the better fix isn't that
far away.  Send the i915 driver and the other misc cleanups to Linus now
and get a proper graphics stub driver done, it's not that much work.  I'll
hack up the fbdev side once I'll get a little time, but the drm code is
far to disgusting to touch, sorry.

