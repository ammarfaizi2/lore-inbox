Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSLBTB1>; Mon, 2 Dec 2002 14:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSLBTB1>; Mon, 2 Dec 2002 14:01:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264877AbSLBTB0>;
	Mon, 2 Dec 2002 14:01:26 -0500
Date: Mon, 2 Dec 2002 11:05:47 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]2.5.49-ac1 - more info on make error
In-Reply-To: <Pine.LNX.3.96.1021202134845.433G-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33L2.0212021103150.27194-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Bill Davidsen wrote:

| On Mon, 2 Dec 2002, Randy.Dunlap wrote:
|
| > On Wed, 27 Nov 2002, Bill Davidsen wrote:
| >
| > | Knowing that modules are still broken, I changed all modules to be
| > | built-in and dropped all support for modules and retried the compile. I
| > | have disabled all but the features I really want to test on the new
| > | kernel, so I will not be reducing the features any more.
| >
| > I haven't seen any replies or fixes for this.  Have you?
|
| No. I have pretty much assumed that there is no interest in having this
| work. The modules are broken to the point where either the author or
| someone who has documentation on how they should work will have to fix
| them. Clearly the policy of "if you want your change in the kernel you
| have to fix what it breaks" is dead.

This is not the borked-modules problem; it's different.

| > drivers/built-in.o(.data+0x31e14): undefined reference to `local symbols
| > in discarded section .exit.text'
| >
| > Please visit http://www.kernelnewbies.org/scripts/ and download
| > the 'reference-discarded.pl' script, run it, and let us know where the
| > problem is.
|
| I posted that to the list, if it didn't make it for any reason I can't
| easily recreate it, the machine has been converted to BSD, the 2.5 work is
| on a removable drive which is removed, since we can't make any progress
| with it for the moment.

whatever.  Adrian Bunk & Jeff Garzik have now posted patches for it.

| It was the old tulip driver which had the problem, de21{something}x.c as I
| recall. Without a doc on what causes that I gave up trying to fix it by
| comparing to other modules.

-- 
~Randy

