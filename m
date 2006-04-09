Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWDIV4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWDIV4o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWDIV4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:56:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55306 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750935AbWDIV4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:56:43 -0400
Date: Sun, 9 Apr 2006 23:56:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/19] kconfig: improve config load/save output
Message-ID: <20060409215637.GE30208@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091727330.23124@scrub.home> <20060409213621.GC30208@mars.ravnborg.org> <Pine.LNX.4.64.0604092347460.32445@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604092347460.32445@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 11:49:55PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 9 Apr 2006, Sam Ravnborg wrote:
> 
> > > +		name = *names++;
> > > +		if (!name)
> > > +			return 1;
> > > +		in = zconf_fopen(name);
> > > +		if (in)
> > > +			goto load;
> > > +		sym_change_count++;
> > 
> > sym_change_count is only used as a flag, not as a counter.
> 
> It was intended as a counter, even it's currently only tested againsted 
> zero.
That I figured out myself. But the intention should not be reflected
years after when the intention did not hold.

	Sam
