Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUBNPUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUBNPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:20:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:46720 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262030AbUBNPUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:20:54 -0500
Date: Sat, 14 Feb 2004 16:21:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Meskes <michael@fam-meskes.de>
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: atkbd.c: Unknown key released/psmouse
Message-ID: <20040214152127.GA397@ucw.cz>
References: <20040214143410.GA2334@1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214143410.GA2334@1>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 03:34:10PM +0100, Michael Meskes wrote:
> Hi,
> 
> I'm using the Debian package of kernel 2.6.2 and get the following message twice whenever I insmod or rmmod psmouse.ko:
> 
> Feb 14 15:28:13 feivel kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> Feb 14 15:28:13 feivel kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> 
> With 2.6.0 all works well, but with 2.6.2 I only get that message and my
> touchpad is not recognized. Yes, my bootprocess does use kbdrate and I'm
> running X at the moment, but this message comes at boottime when
> processing /etc/modules too.
> 
> Strangely enough a few underterministic times it comes up correctly. Now
> message is printed and my touchpad works. But most of the time I just
> get that message.
> 
> I didn't find any mention of this on the web so I figure to ask here.
 
Please try eith 2.6.3-rc, there was a bug in 2.6.2 in i8042.c that could
cause all kinds of errors like this.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
