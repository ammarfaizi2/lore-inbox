Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQJ3Je7>; Mon, 30 Oct 2000 04:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQJ3Jes>; Mon, 30 Oct 2000 04:34:48 -0500
Received: from chiara.elte.hu ([157.181.150.200]:46342 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129038AbQJ3Jeh>;
	Mon, 30 Oct 2000 04:34:37 -0500
Date: Mon, 30 Oct 2000 11:44:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030022024.B20023@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301142040.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> This is putrid. NetWare does 353,00,000/second on a Xenon, pumping out
> gobs of packets in between them. MANOS does 857,000,000/second. This
> is terrible. No wonder it's so f_cking slow!!!

(no need to get emotional.) And please check your numbers, 857 million
context switches per second means that on a 1 GHZ CPU you do one context
switch per 1.16 clock cycles. Wow!

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
