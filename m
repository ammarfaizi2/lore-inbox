Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVEJMra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEJMra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEJMra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:47:30 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:4845 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261631AbVEJMrT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:47:19 -0400
Date: Tue, 10 May 2005 14:40:06 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 driver works also with ds1339 chip
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <u7zs9Dp4.1115728806.6659250.khali@localhost>
In-Reply-To: <20050510120804.GA2492@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> > next to the end of the ds1337 driver. Maybe it would also make sense to
> > have a ds1337.h header file declaring this function?
>
> I'm not sure if adding yet another driver specific header is a good
> idea. Perhaps we should consolidate I2C RTC drivers a bit more and
> create common header for them?

Agreed, although I would go one step further. I see no reason why it
matters whether these are *I2C* RTC or not. I have no concrete proposal
but it really sounds like a common RTC interface would be needed here -
if it doesn't exist already. Can't say more unfortunately, as I never
had to use a RTC myself.

> Document the fact that ds1337 driver works also with DS1339 real-time
> clock chip.

Good work, thanks.

--
Jean Delvare
