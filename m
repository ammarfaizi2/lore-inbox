Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319050AbSIJGdV>; Tue, 10 Sep 2002 02:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSIJGdV>; Tue, 10 Sep 2002 02:33:21 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:65037 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S319050AbSIJGdU>;
	Tue, 10 Sep 2002 02:33:20 -0400
Message-Id: <200209100637.g8A6bMm01628@fokkensr.vertis.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] USER_HZ & NTP problems
Date: Tue, 10 Sep 2002 08:37:17 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <200209092314.g89NEnA05992@fokkensr.vertis.nl> <20020910080941.A6298@ucw.cz>
In-Reply-To: <20020910080941.A6298@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 08:09, Vojtech Pavlik wrote:
> Actually, the clock true frequency is 1193181.8 Hz, although most
> manuals say 1.19318 MHz, which, because truncating more digits, also
> correct. But 1193180 Hz isn't. If you're trying to count the time
> correctly, you should better use 1193182 Hz if staying in integers.

I copied the clock frequency from the kernel source, timex.h defines:

#define CLOCK_TICK_RATE 1193180

If what you're saying is correct, timex.h uses the wrong value as wel I guess.
