Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWANQoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWANQoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWANQoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:44:20 -0500
Received: from styx.suse.cz ([82.119.242.94]:21906 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751778AbWANQoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:44:19 -0500
Date: Sat, 14 Jan 2006 17:44:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull 0/7] Another input update for 2.6.15
Message-ID: <20060114164441.GA19408@midnight.suse.cz>
References: <20060114151645.035957000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114151645.035957000.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 10:16:45AM -0500, Dmitry Torokhov wrote:
> Hi Linus,
> 
> Please do a pull from:
> 
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/
> or
> 	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git/
> 
> The main feature is psmouse resync patch which should make PS/2 mice
> useable with cheap KVMs that reset mice when switching between boxes.
> Also there is a fix for OOps in PID code, build for for powerpc and
> HID tweaks to make new USB-based keyboards behave like older ADB ones.
> 
> Changelog:
> 
> 	Input: i8042 - add Sony Vaio FSC-115b to MUX blacklist (Vojtech)
> 	Input: HID - add support for Cherry Cymotion keyboard (Vojtech)
> 	Input: HID - fix an oops in PID initialization code
> 	Input: psmouse - attempt to re-synchronize mouse every 5 seconds
> 	Input: HID - add more simulation usages
> 	Input: wacom - fix compile on PowerPC
> 	Input: HID - add support for fn key on Apple PowerBooks (Michael Hanselmann)

Thanks for ccing me, the patches look all OK to me.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
