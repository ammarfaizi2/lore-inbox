Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTFBPi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTFBPi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:38:59 -0400
Received: from windsormachine.com ([206.48.122.28]:32273 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262483AbTFBPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:38:56 -0400
Date: Mon, 2 Jun 2003 11:52:20 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
cc: <linux-smp@vger.kernel.org>
Subject: Re: Hyper-threading
In-Reply-To: <Pine.LNX.4.53.0306021124570.16188@chaos>
Message-ID: <Pine.LNX.4.33.0306021147460.31561-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Richard B. Johnson wrote:

> Well it is supposed to. It's a pentium 4 Xeon. If it doesn't
> support it, ether the CPU or the motherboard are broken.
> I'll bet on the motherboard.
> Look further up the dmesg output and you'll see XEON(tm) and
> 2 CPUs total.

Indeed, I saw that.  On the P4 2.66ghz that you have, the "second" cpu is
disabled by intel, as they sell hyperthreading only on the newer Xeon P4
(which you don't have), and the new 800FSB (4x200) units, which again
you don't have.

..... CPU clock speed is 2672.7802 MHz.
..... host bus clock speed is 133.6388 MHz.

There is a Xeon 2.66 part, however it has 603 pins, and would not fit on
your IC7-G board, which is a P4 board, not a P4 Xeon board,

CPU0: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07 is correct.

OT:  Are your two 100mbit cards PCI or something?  I noticed the onboard
gigabit adapter isn't detected.

Mike

