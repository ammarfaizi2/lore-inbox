Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262165AbSJARyI>; Tue, 1 Oct 2002 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbSJARyI>; Tue, 1 Oct 2002 13:54:08 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:37853 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S262165AbSJARyH>; Tue, 1 Oct 2002 13:54:07 -0400
Message-Id: <200210011811.g91IBt5Y000464@pool-141-150-241-241.delv.east.verizon.net>
Date: Tue, 1 Oct 2002 14:11:53 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <200210011649.g91GnDfG000953@pool-141-150-241-241.delv.east.verizon.net> <20021001185154.A13641@ucw.cz> <200210011741.g91HfR5Y000241@pool-141-150-241-241.delv.east.verizon.net> <20021001193938.A14179@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001193938.A14179@ucw.cz>; from vojtech@suse.cz on Tue, Oct 01, 2002 at 07:39:38PM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Tue, 1 Oct 2002 12:59:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Oct 01, 2002 at 01:41:27PM -0400, Skip Ford wrote:
> > Vojtech Pavlik wrote:
> > > On Tue, Oct 01, 2002 at 12:49:08PM -0400, Skip Ford wrote:
> > > >
> > > > The new AT driver
> > > > doesn't log any 'unknown scancode' messages for the same buttons the
> > > > old XT driver did.
> > > 
> > > That means it understands them. If it did not, showkey -s wouldn't work.
> > > 
> > > Just update the keymap - you don't need to change the scancode table if
> > > the keys are working.
> > 
> > How do I make use of these keycodes in a map file?
> > 
> > 0  press
> > 1  release
> > 14 release
> > 
> > 0  press
> > 1  release
> > 15 release
> 
> 0,1,14 is keycode 142 (Sleep) and 0,1,15 is keycode 143 (WakeUp),
> encoded because medium raw mode cannot handle keycodes above 128. If
> loadkeys doesn't allow keycodes 142 and 143, well, I'll have to fix it.

You'll have to fix it.  I tried those before I asked.  Actually I tried
141 and 142 but I was close.  loadkeys rejects anything >= NR_KEYS (128)

All of my keys are recognized so I don't need any setkeycodes
functionality at all.  I can probably get loadkeys to load my map so I
should be ok now.  I was making things a lot harder than they had to be.

-- 
Skip
