Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUAENWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUAENWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:22:39 -0500
Received: from lde1084.emirates.net.ae ([217.165.122.68]:10761 "EHLO
	athena.localdomain") by vger.kernel.org with ESMTP id S264256AbUAENWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:22:38 -0500
Date: Mon, 5 Jan 2004 17:23:27 +0400 (GST)
From: Amit Gurdasani <amitg@alumni.cmu.edu>
X-X-Sender: amitg@athena.localdomain
To: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
In-Reply-To: <20040104162654.A27227@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0401051713370.4783@athena.localdomain>
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com>
 <Pine.LNX.4.56.0312300338360.1163@athena> <20031229225037.GB3198@neo.rr.com>
 <20040104162654.A27227@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004, Russell King wrote:

:On Mon, Dec 29, 2003 at 10:50:37PM +0000, Adam Belay wrote:
:> > ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
:> > ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
:> > ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
:> > parport0: irq 7 detected
:>
:> Hmm, it shouldn't be reporting irq 0.  The probbing code may be confused.
:> I would guess it is on irq 4.
:
:irq0 on x86 means "I'll use polled mode".

Does this imply a performance reduction whether or not I actually have a
device connected to the port? And would this imply that the serial port
should remain functional despite there being no interrupt line assigned to
it?

What sort of performance degradation (in terms of CPU utilization, latency,
throughput, or otherwise) can I expect from a serial port operating in
polled mode?

Thanks,

Amit
