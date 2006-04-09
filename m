Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWDIVz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDIVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWDIVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:55:27 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:31754 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750897AbWDIVz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:55:27 -0400
Date: Sun, 9 Apr 2006 23:55:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/19] kconfig: recenter menuconfig
Message-ID: <20060409215520.GD30208@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091726550.23116@scrub.home> <20060409212548.GA30208@mars.ravnborg.org> <Pine.LNX.4.64.0604092341130.32445@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604092341130.32445@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 11:46:00PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 9 Apr 2006, Sam Ravnborg wrote:
> 
> > With this change when window width is > 80 then we waste half of
> > the screen width only to right-indent the menus.
> 
> Currently we waste a lot of screen on right side, which is not much 
> different.
Thats normal behaviour vi does the same for this text.

> Further there is now a mix of left aligned and centered output, 
> which is ugly
So we should fix the rest too instead of reintroducing the old
behaviour.

> 
> > We truncate longer prompts and with this we require twice the
> > width to see full prompt.
> 
> If these longer prompts don't fit into a 80 coloumn window, it's a bug.

Try to add three directories somewhere deep to "Initramfs source file(s)".
Thats where I have been hit by the limitation today.

	Sam
