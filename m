Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUAIV4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUAIV4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:56:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:62183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263861AbUAIVzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:55:15 -0500
Date: Fri, 9 Jan 2004 13:56:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Whiting <ewhiting@amis.com>
Cc: linux-kernel@vger.kernel.org, scott.feldman@intel.com, cramerj@intel.com
Subject: Re: e1000 in 2.6.1-mm1 -- still broken?
Message-Id: <20040109135613.255b36e8.akpm@osdl.org>
In-Reply-To: <3FFF147E.F68F246D@amis.com>
References: <3FFF147E.F68F246D@amis.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Whiting <ewhiting@amis.com> wrote:
>
> 
> I'm having trouble with e1000 in -mm1. (works in 2.6.1) The device is detected
> and shows up and can be configured, but nothing ever goes out on the wire. 

Hum, OK.  We'd better Cc the maintainers.


> Here is the device info:
> 
> 
> 07:01.1 Ethernet controller: Intel Corporation: Unknown device 1010 (rev 01)
>         Subsystem: Intel Corporation: Unknown device 1011
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 49
>         Memory at fe9e0000 (64-bit, non-prefetchable) [size=128K]
>         I/O ports at dc00 [size=64]
>         Capabilities: [dc] Power Management version 2
>         Capabilities: [e4] PCI-X non-bridge device.
>         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable-
> 
> 
> tcpdump shows no activity when I attempt to use the e1000 interface.

