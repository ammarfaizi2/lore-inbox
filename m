Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTJ0Uj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTJ0Uj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:39:58 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:63105
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263498AbTJ0Uj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:39:57 -0500
Date: Mon, 27 Oct 2003 15:39:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
cc: linux-kernel@vger.kernel.org
Subject: RE: [BUG] R8169 on 2.6.0-test9
In-Reply-To: <070c01c39c76$4579ccb0$034d210a@sandos>
Message-ID: <Pine.LNX.4.53.0310271537260.21953@montezuma.fsmlabs.com>
References: <070c01c39c76$4579ccb0$034d210a@sandos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, John Bäckstrand wrote:

> I have tried the r8169 driver on 2.4.22 and 2.6.0-test9, and r8139cp on
> 2.4.20. On 2.4.22, it printed "too much work at interrupt" forever after
> 3-60 seconds of connection to a lan. I commented the printk out, that didnt
> help though. The behaviour is exactly the same on 2.6.0-test9 and 2.4.20, a
> few seconds after "ifconfig eth1 up" the machine hangs, though on 2.4.20
> atleast there was no printk message seen. ifconfig shows it does receive and
> send a few packets before it hangs, atleast on 2.4.22. The 8169 cards have
> been confirmed to be working, but not on this particular motherboard though.

Let's stick to r8169 for now, can you send a dmesg from test9 also throw 
in /proc/interrupts.

