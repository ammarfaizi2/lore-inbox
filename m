Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276921AbRJCIty>; Wed, 3 Oct 2001 04:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276926AbRJCItf>; Wed, 3 Oct 2001 04:49:35 -0400
Received: from chiara.elte.hu ([157.181.150.200]:41479 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276922AbRJCIt0>;
	Wed, 3 Oct 2001 04:49:26 -0400
Date: Wed, 3 Oct 2001 10:47:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Marcus Sundberg <marcus@cendio.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <ve8zeuy1qs.fsf@inigo.sthlm.cendio.se>
Message-ID: <Pine.LNX.4.33.0110031045190.1912-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Oct 2001, Marcus Sundberg wrote:

> Guess my P3-based laptop doesn't count as modern then:
>
>   0:    7602983          XT-PIC  timer
>   1:      10575          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>  11:  1626004 XT-PIC Toshiba America Info Systems ToPIC95 PCI to
> Cardbus Bridge with ZV Support, Toshiba America Info Systems ToPIC95
> PCI to Cardbus Bridge with ZV Support (#2), usb-uhci, eth0, BreezeCom
> Card, Intel 440MX, irda0

ugh!

> I can't even imagine why they did it like this...

well, you arent going to be using it as a webserver i guess? :) But the
costs on desktops are minimal. It's the high-irq-rate server environments
that want separate irq sources.

	Ingo

