Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbQKUToQ>; Tue, 21 Nov 2000 14:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbQKUToH>; Tue, 21 Nov 2000 14:44:07 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:35332 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131116AbQKUTny>; Tue, 21 Nov 2000 14:43:54 -0500
Date: Tue, 21 Nov 2000 19:13:14 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Erdfelt <jerdfelt@valinux.com>
cc: Oleg Drokin <green@ixcelerator.com>, <linux-kernel@vger.kernel.org>
Subject: Re: hardcoded HZ in hub.c
In-Reply-To: <20001121095626.F3431@valinux.com>
Message-ID: <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Johannes Erdfelt wrote:

> That that possible? usb_hub_events can block for a long time. That is why
> the kernel thread was needed. I'm not familiar with schedule_task enough
> to know if it can be used.

Ah. How long? At first glance, it didn't look to me as if it would sleep
for long at all.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
