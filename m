Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTK1WrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 17:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTK1WrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 17:47:17 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:29683 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263523AbTK1WrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 17:47:16 -0500
Date: Sat, 29 Nov 2003 11:27:17 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: APM Suspend Problem
In-reply-to: <20031128215031.GC8039@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Misha Nasledov <misha@nasledov.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1070058437.2380.43.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20031127062057.GA31974@nasledov.com>
 <20031128212853.GB8039@holomorphy.com> <20031128215008.GA2541@nasledov.com>
 <20031128215031.GC8039@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

Dunno if I'm an expert, but I might be able to help. None of the Linux
based suspends (2.4 or 2.6) will get started unless something like acpid
pushes them. If a laptop suspends without running acpid or similar, it
must be doing it from the BIOS.

Regards,

Nigel

On Sat, 2003-11-29 at 10:50, William Lee Irwin III wrote:
> On Fri, Nov 28, 2003 at 01:50:08PM -0800, Misha Nasledov wrote:
> > It would be really annoying if my laptop suspended when I closed the lid; I
> > disabled this feature in the BIOS. I will test if it suspends with
> > this feature enabled, but it doesn't change the fact that there is
> > something broken with APM. Running 'apm --suspend' doesn't work either.
> 
> That sounds h0rked; we might need to drag in suspend experts for this...
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

