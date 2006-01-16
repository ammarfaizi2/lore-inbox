Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWAPJyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWAPJyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWAPJyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:54:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41604 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932300AbWAPJyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:54:53 -0500
Date: Mon, 16 Jan 2006 10:54:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Thomas Fazekas <thomas.fazekas@gmail.com>, linux-kernel@vger.kernel.org,
       arch@archlinux.org
Subject: Re: Modify setterm color palette
Message-ID: <20060116095439.GA26658@elf.ucw.cz>
References: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com> <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr> <20060115131620.GA24976@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115131620.GA24976@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 15-01-06 13:16:20, Russell King wrote:
> On Sun, Jan 15, 2006 at 01:15:23PM +0100, Jan Engelhardt wrote:
> > drivers/char/vt.c: default_red, default_grn, default_blu
> > 
> > You can also change them with `echo -en "\e]PXRRGGBB"`, where X is a hex 
> > digit (range 0-F), and RGB are the components. Check console_codes(4) and 
> > go figure. :)
> 
> I for one prefer the standard VT100 yellow instead of brown, and I
> have an escape sequence to do that similar to the one you show above.
> 
> However, there's one major flaw - programs recently (and by that I mean
> FC2-like recently) have started to do complete console resets, which
> result in the users settings being completely wiped out.

Yep, I've seen those problems too. OTOH probably its userland programs
that should be fixed not to reset terminals?
								Pavel
-- 
Thanks, Sharp!
