Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUE3VEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUE3VEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUE3VEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:04:36 -0400
Received: from main.gmane.org ([80.91.224.249]:39376 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264397AbUE3VAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:00:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 22:51:18 +0200
Message-ID: <MPG.1b2467af841573119896ae@news.gmane.org>
References: <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz> <MPG.1b2424ed871e68c89896aa@news.gmane.org> <20040530203146.GA1941@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-113-140.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 06:08:39PM +0200, Giuseppe Bilotta wrote:
> 
> > > The Linux kernel reports them as KEY_LEFTMETA, KEY_RIGHTMETA and
> > > KEY_COMPOSE.
> > 
> > In X standard keyboards Meta is mapped as the second symbol for 
> > Alt.

[snip]

> Interesting. Nevertheless it's just a naming difference, and thus
> shouldn't be a problem.

Well, it's not just that, not if we want Meta kernel keys to 
become Meta X keys. Which wouldn't be a bad thing, since it 
would mean we'd have the keyboard acting the same under console 
and X. But in this case it would be nice if Linux knew about 
more modifiers than just shift, ctrl, alt, meta.

> > > I'm not very familiar with xkb configuration. Perhaps you'd be willing
> > > to write that definition file? I'll certainly help you from the kernel
> > > side - I can even generate a list of keycode - scancode - meaning
> > > relations for you.
> > 
> > If you do generate a list of keycode - scancode - meaning pairs 
> > it will surely make my life easier.
> > 
> > I'm not particularly familiar with xkb configuration either. I 
> > can *probably* make it work (i.e. test it as functional) on my 
> > Dell Inspiron 8200 keyboard and on a standard pc104 keyboard 
> > only. You probably need somebody else to work out the details 
> > for other keyboards, though.
> 
> Ok, I'll try to produce something.

Thanks.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

