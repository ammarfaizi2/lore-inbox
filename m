Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUABUKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265640AbUABUKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:10:14 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:41611 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265639AbUABUKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:10:08 -0500
Date: Fri, 2 Jan 2004 21:10:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Go Taniguchi <go@turbolinux.co.jp>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1 with JP106 keyboard
Message-ID: <20040102201015.GA3080@ucw.cz>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <3FF4F8EA.6090602@turbolinux.co.jp> <20040102131737.GB395@ucw.cz> <3FF5C015.7050806@turbolinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF5C015.7050806@turbolinux.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 04:01:41AM +0900, Go Taniguchi wrote:

> >>Hi,
> >>2.6.1-rc1 with JP106 keybord. keycode was changed....
> >>                                        2.6.0 -> 2.6.1-rc1
> >>lower-right backslash (scancode 0x73)   89    -> 181
> >>upper-right backslash (scancode 0x7d)   183   -> 182
> > 
> > 
> > These two scancodes are defined as japanese language selection keys.
> > Hence the atkbd.c driver delivers these as such. What should be updated
> > is the default keymap (defkeymap.map, defkeymap.c).
> > 
> 
> Thank you so much.
> I try so that it can be solved.
> > What should be updated  is the default keymap (defkeymap.map, defkeymap.c).
> Sorry, does this mean that a default key map is re-defined?
> We need to add 181 and 182 keycodes to the keymap?

Exactly so.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
