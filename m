Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTGARGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTGARGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:06:34 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55450 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263103AbTGARFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:05:14 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 1 Jul 2003 10:11:41 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Diego Zuccato <diego@otello.alma.unibo.it>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SIS IO-APIC troubles
In-Reply-To: <3F014378.6D3F598C@otello.alma.unibo.it>
Message-ID: <Pine.LNX.4.55.0307011009540.4730@bigblue.dev.mcafeelabs.com>
References: <3F014378.6D3F598C@otello.alma.unibo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Diego Zuccato wrote:

> Hello.
>
> I'm trying to install Linux on an Acer Aspire 1700. To be able to boot,
> I've had to use "noapic" parameter. But, then, many peripherals won't
> work (like USB2) or they'll be sluggish (like nic that reaches about
> 80KB/s in a direct 100Mbps link).
> I've put all the info I could gather at
> http://otello.alma.unibo.it/~diego/Aspire1700/ .
> Since it's not my machine, but a friend lets me experiment with it, it's
> better if I have a list of tests to try.

You have a SiS650 chipset and this will help the IRQ routing :

http://www.xmailserver.org/linux-patches/misc.html#SiSRt



- Davide

