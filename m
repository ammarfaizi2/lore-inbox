Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUBOSCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 13:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUBOSCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 13:02:18 -0500
Received: from cathy.bmts.com ([216.183.128.202]:22951 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S265125AbUBOSCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 13:02:17 -0500
Date: Sun, 15 Feb 2004 13:02:14 -0500
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
Message-Id: <20040215130214.658e30ab.mikeserv@bmts.com>
In-Reply-To: <1076825785.6960.3.camel@gaston>
References: <1076825785.6960.3.camel@gaston>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The new radeonfb driver appears to work nicely (except a bit of corruption when it first switches, but it's always done that for me in 2.6), until I start and exit XFree86. I then have display corruption. Text is scrambled and appearing where it's not supposed to be. If I type clear, the display becomes unusable. The text appears with lines through it, and I'm then typing blindly. I can still type commands though.

I then recompiled my kernel to use the old radeonfb driver, but it doesn't seem to work at all. The system won't switch to framebuffer mode during boot, with append = "video=radeonfb:1024x768-8@76".

So I recompiled again with the new driver, as I must have a framebuffer console.

This is a pentium4 system, on an i845 chipset with an ATI Radeon 7500 AGP card. I'm not sure if these are needed, so I've put my config and dmesg output up on my personal web space instead of pasting in this email.

http://www.bitbenderforums.com/~grogan/files/config-2.6.3-rc3.txt
http://www.bitbenderforums.com/~grogan/files/dmesg-2.6.3-rc3.txt

Thanks,
Mike Houston (a.k.a. Grogan)
