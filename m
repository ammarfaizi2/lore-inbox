Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbUAFFOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUAFFOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:14:33 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:62594
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265830AbUAFFOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:14:32 -0500
Date: Tue, 6 Jan 2004 00:13:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 vs. vga option
In-Reply-To: <173a01c3cceb$0432e110$43ee4ca5@DIAMONDLX60>
Message-ID: <Pine.LNX.4.58.0401060008390.3405@montezuma.fsmlabs.com>
References: <173a01c3cceb$0432e110$43ee4ca5@DIAMONDLX60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003, Norman Diamond wrote:

> On a machine with a Neomagic NM2200 [MagicGraph 256AV] VGA controller, under
> 2.6.0, boot parameter vga=0x317 causes a blank screen and might be hanging
> the entire machine.  There is no response to Ctrl-Alt-Del.  Holding the
> power switch for 4 seconds results in a warning beep from the BIOS and then
> power down.
>
> This is very similar to problems that were reported during 2.6.0-test days,
> with an older Neomagic chip and smaller screen.  I don't recall if
> Ctrl-Alt-Del might have yielded a reboot at that time.
>
> As always, this can be fixed by booting 2.4.20.  Or by omitting the vga=
> parameter.
>
> Oddly, I have found some combination of drivers to compile as built-in and
> some to compile as modules, so that early in the boot sequence the screen
> automatically switches from 80x25 to somewhere around 128x40 even without
> the vga= parameter.  No free penguin though.

This sounds similar to;

http://bugzilla.kernel.org/show_bug.cgi?id=1458

I just got back from holiday so i'll look further into it, feel free to
add yourself to the Cc list for the bug.
