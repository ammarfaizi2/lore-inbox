Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUG0RyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUG0RyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUG0RxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:53:24 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:3206 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266495AbUG0RxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:53:18 -0400
Date: Tue, 27 Jul 2004 19:54:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, aebr@win.tue.nl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040727175439.GA1358@ucw.cz>
References: <87llhjlxjk.fsf@devron.myhome.or.jp> <20040716164435.GA8078@ucw.cz> <20040716201523.GC5518@pclin040.win.tue.nl> <871xjbkv8g.fsf@devron.myhome.or.jp> <20040726154327.107409fc.akpm@osdl.org> <20040727134654.GB17362@ucw.cz> <878yd5be4z.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878yd5be4z.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 01:37:00AM +0900, OGAWA Hirofumi wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > > This all seems a bit inconclusive.  Do we proceed with the original patch
> > > or not?  If not, how do we fix the overflow which Hirofumi has identified?
> > 
> > I think we should check the value in the ioctl, regardless of what's
> > NR_KEYS defined to.
> 
> However, it breaks the current binary instead. (at least
> console-tools, kbdutils).
 
We can do both, then, if that helps.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
