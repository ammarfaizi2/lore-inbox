Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280761AbRKSWu1>; Mon, 19 Nov 2001 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRKSWuS>; Mon, 19 Nov 2001 17:50:18 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:41892 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S280762AbRKSWuI>; Mon, 19 Nov 2001 17:50:08 -0500
Date: Mon, 19 Nov 2001 23:48:49 +0100
From: Sven.Riedel@tu-clausthal.de
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
Message-ID: <20011119234849.A320@moog.heim1.tu-clausthal.de>
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de> <200111191611.fAJGBKQ30686@deathstar.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111191611.fAJGBKQ30686@deathstar.prodigy.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 11:11:20AM -0500, bill davidsen wrote:
> In article <3BF32B36.8B1375D0@neo.shinko.co.jp> nakai@neo.shinko.co.jp wrote:
> >I think you'd be better compile kernel for K6, not for K7.  There is
> >something wrong with KT133 chip set and Athlon/Duron.
> 
> There is a patch for this chipset around, which AFAIK was never put in
> the kernel because the exact function of the patch was not known WRT the
> chipset internals.
I guess you mean Kurt Garloffs patch that turned certain features on and
off, since the bit 55 disable patch is in 2.4.14. Unfortunately, I still
get the Oops after applying this patch (and the quirk-fixes were
executed before the oops).

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
