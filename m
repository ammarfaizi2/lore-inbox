Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbTA1PuH>; Tue, 28 Jan 2003 10:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTA1PuH>; Tue, 28 Jan 2003 10:50:07 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:9651 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267342AbTA1PuG>; Tue, 28 Jan 2003 10:50:06 -0500
Date: Tue, 28 Jan 2003 16:59:22 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030128155922.GF10685@wohnheim.fh-wedel.de>
References: <20030128155312.GD10685@wohnheim.fh-wedel.de> <20030128165719.A382@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030128165719.A382@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 January 2003 16:57:19 +0100, Vojtech Pavlik wrote:
> On Tue, Jan 28, 2003 at 04:53:12PM +0100, Jörn Engel wrote:
> > 
> > Without the patch below, the \0 terminating the string is written
> > anywhere. nibbles[] would be even better, I guess.
> 
> Well, the zero isn't used, so it might make sense to use '0', 'A', 'B' ...
> ... though that's not very nice either.

And maintenance wins over any byte of memory. :)

> > Can you check for stupidity on my side?
> 
> Can't find any. ;) Patch applied with [].

Cool!

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
