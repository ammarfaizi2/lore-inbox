Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265939AbUFOUgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUFOUgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUFOUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:36:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36485 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265939AbUFOUg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:36:29 -0400
Date: Tue, 15 Jun 2004 22:37:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org, Lubomir Prech <Lubomir.Prech@mff.cuni.cz>
Subject: Re: omnibook xe4500 keyboard works where shouldn't
Message-ID: <20040615203714.GB2686@ucw.cz>
References: <20040615143339.A6328@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615143339.A6328@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:33:39PM +0000, Karel Kulhavý wrote:
> Hello
> 
> Somehow I managed to determine a linux kernel configuration where at least the
> keyboard works upon startup:
> 
> USB HID is off at all
> Input core kbd is off
> Input core mouse is on.
> USB is on.
> 
> The question is: How is it possible the keyboard works when it is
> switched off on two (=all possible) places at the same time?
> 
> So, if it's a PS/2 keyboard, it's swiched off by input core.

I told you once, the PS/2 keyboard always works in 2.4. It cannot be
switched off. It uses a direct interface to the console, and doesn't use
USB or INPUT or anything else.

Input core is ONLY used for USB on 2.4. Enough?

> If it's a USB keyboard it's switched off by USB HID.

Any internal keyboard is a PS/2 keyboard.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
