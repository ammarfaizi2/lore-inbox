Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVA2TKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVA2TKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVA2TJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:09:08 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:57294 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261534AbVA2TIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:11 -0500
Date: Sat, 29 Jan 2005 12:30:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: USB HID events and Microsoft wheel mouse
Message-ID: <20050129113019.GD2268@ucw.cz>
References: <9e4733910501282002665eb532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501282002665eb532@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 11:02:52PM -0500, Jon Smirl wrote:

> Something changed in the Linus BK kernel in the last few days so that
> I get "drivers/usb/input/hid-input.c: event field not found" in dmesg
> everytime I move my MS Wheel mouse. Any ideas on how to get rid of
> this?
> 
> The events are EV_MISC:
> type 4 code 4 value 65585
> type 4 code 4 value 65584
> type 4 code 4 value 589825

The events are raw HID usages, and they're intentional. The "event field
not found" is a bug, sorry, and I'll fix it ASAP.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
