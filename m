Return-Path: <linux-kernel-owner+willy=40w.ods.org-S291878AbUKBAMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S291878AbUKBAMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291125AbUKBAG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:06:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39861 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S384349AbUKBAFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:05:42 -0500
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the
	UPkernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <418643E2.9080006@microgate.com>
References: <000201c4bfe2$7389eeb0$294b82ce@stuartm>
	 <418643E2.9080006@microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099350132.18809.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 23:02:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-01 at 14:10, Paul Fulghum wrote:
> I was thought it was to speed processing if the
> caller was already in process context. Maybe the
> real intentions are lost to history.

It was added way back by Ted to improve performance when dealing with
low latency requirements for I/O. 

> Moving forward, Alan stated that the flip
> routine should not be called in interrupt context.
> His last post concerning some transient state
> of low_latency has confused me.

You were correct about that


