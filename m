Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131008AbQKUT4e>; Tue, 21 Nov 2000 14:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQKUT4Y>; Tue, 21 Nov 2000 14:56:24 -0500
Received: from quattro.sventech.com ([205.252.248.110]:9740 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S131008AbQKUT4R>; Tue, 21 Nov 2000 14:56:17 -0500
Date: Tue, 21 Nov 2000 14:26:17 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c
Message-ID: <20001121142616.L7764@sventech.com>
In-Reply-To: <20001121095626.F3431@valinux.com> <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk>; from David Woodhouse on Tue, Nov 21, 2000 at 07:13:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 21 Nov 2000, Johannes Erdfelt wrote:
> 
> > That that possible? usb_hub_events can block for a long time. That is why
> > the kernel thread was needed. I'm not familiar with schedule_task enough
> > to know if it can be used.
> 
> Ah. How long? At first glance, it didn't look to me as if it would sleep
> for long at all.

Multiple seconds in the worst case.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
