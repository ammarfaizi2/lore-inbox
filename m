Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUAYTuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUAYTu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:50:27 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:62338
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265238AbUAYTuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:50:18 -0500
Date: Sun, 25 Jan 2004 10:28:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Huw Rogers <count0@localnet.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-laptop@mobilix.org
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT
 problems on Uniwill N258SA0
In-Reply-To: <20040124233749.5637.COUNT0@localnet.com>
Message-ID: <Pine.LNX.4.58.0401251018530.1741@montezuma.fsmlabs.com>
References: <20040124233749.5637.COUNT0@localnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004, Huw Rogers wrote:

> irqbalance just locks up the machine totally, hard power-off needed, no
> traces in the logs. Probably some issue (race?) with it writing to
> /proc/irq/X/smp_affinity. And how is irqbalance supposed to play with
> kirqd anyway? Grepping this list and others doesn't give any kind of an
> answer. But disabling it gives all interrupts to cpu0 (looking at
> /proc/interrupts). kirqd apparently only balances between CPU packages,
> not between HT siblings (info gleaned from this list).

Does this happen with the 'noirqbalance' kernel parameter?
