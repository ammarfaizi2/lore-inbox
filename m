Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262833AbSJAUsH>; Tue, 1 Oct 2002 16:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbSJAUsH>; Tue, 1 Oct 2002 16:48:07 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9887 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262833AbSJAUsF>;
	Tue, 1 Oct 2002 16:48:05 -0400
Date: Tue, 1 Oct 2002 22:53:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Skip Ford <skip.ford@verizon.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021001225325.C15796@ucw.cz>
References: <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <200210011649.g91GnDfG000953@pool-141-150-241-241.delv.east.verizon.net> <20021001185154.A13641@ucw.cz> <200210011741.g91HfR5Y000241@pool-141-150-241-241.delv.east.verizon.net> <20021001193938.A14179@ucw.cz> <200210011811.g91IBt5Y000464@pool-141-150-241-241.delv.east.verizon.net> <20021001203817.B14385@ucw.cz> <200210012004.g91K4SC7000390@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210012004.g91K4SC7000390@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Tue, Oct 01, 2002 at 04:04:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 04:04:27PM -0400, Skip Ford wrote:

> Vojtech Pavlik wrote:
> > 
> > Well, if you get loadkeys to load the high keycodes, then indeed
> > everything is fine.
> 
> Disregard my other email.  I can get it to work if I redefine NR_KEYS in
> keyboard.h then rebuild the kernel and loadkeys using the new value.
> 
> My map with extended keycodes loads and all the multimedia keys work
> without using setkeycodes.  Have I done something horrible by upping
> NR_KEYS?

I don't think so it should be fine - actually NR_KEYS should be the same
as KEY_MAX in input.h probably.

-- 
Vojtech Pavlik
SuSE Labs
