Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTDDCYA (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 21:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTDDCYA (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 21:24:00 -0500
Received: from [12.47.58.55] ([12.47.58.55]:26045 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263612AbTDDCXz (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 21:23:55 -0500
Date: Thu, 3 Apr 2003 18:36:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm3: hang and crash
Message-Id: <20030403183604.6a4cc385.akpm@digeo.com>
In-Reply-To: <20030404013732.GA466@zip.com.au>
References: <20030404013732.GA466@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 02:35:16.0648 (UTC) FILETIME=[D3BDAA80:01C2FA52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> Just tried mm3 for the fun of it with two results:
> 
> 1. If I leave my Xircom card in the PCMCIA slot, the kernel hangs at the 
>    following point during boot:
> 
> 
> Yenta IRQ list 00b8, PCI irq 10
> Socket Status: 30000820
> *hang*
> 
>    This does not happen if the card is not in plugged in.

Russell is working on that one.

> 2. After I booted, I logged into X, started up my mutts (6 of em) and
>    started moving the mouse cursor about. Laptop turned itself off.

The first thing to do when a -mm kernel mysteriously explodes is to try just
the Linus part.  Could you please do that?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/linus.patch

It is against 2.5.66.

