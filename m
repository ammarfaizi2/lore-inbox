Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSJAUDh>; Tue, 1 Oct 2002 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSJAUDh>; Tue, 1 Oct 2002 16:03:37 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:45966 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S262235AbSJAUDg>; Tue, 1 Oct 2002 16:03:36 -0400
Message-Id: <200210012004.g91K4SC7000390@pool-141-150-241-241.delv.east.verizon.net>
Date: Tue, 1 Oct 2002 16:04:27 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
References: <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <200210011649.g91GnDfG000953@pool-141-150-241-241.delv.east.verizon.net> <20021001185154.A13641@ucw.cz> <200210011741.g91HfR5Y000241@pool-141-150-241-241.delv.east.verizon.net> <20021001193938.A14179@ucw.cz> <200210011811.g91IBt5Y000464@pool-141-150-241-241.delv.east.verizon.net> <20021001203817.B14385@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001203817.B14385@ucw.cz>; from vojtech@suse.cz on Tue, Oct 01, 2002 at 08:38:17PM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [141.150.241.241] at Tue, 1 Oct 2002 15:08:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> Well, if you get loadkeys to load the high keycodes, then indeed
> everything is fine.

Disregard my other email.  I can get it to work if I redefine NR_KEYS in
keyboard.h then rebuild the kernel and loadkeys using the new value.

My map with extended keycodes loads and all the multimedia keys work
without using setkeycodes.  Have I done something horrible by upping
NR_KEYS?

-- 
Skip
