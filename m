Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEVpY>; Fri, 5 Jan 2001 16:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEVpO>; Fri, 5 Jan 2001 16:45:14 -0500
Received: from 209.102.21.2 ([209.102.21.2]:41992 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129183AbRAEVpB>;
	Fri, 5 Jan 2001 16:45:01 -0500
Message-ID: <3A560FDA.ABB3EF08@goingware.com>
Date: Fri, 05 Jan 2001 18:18:02 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Silly question, but have you realized that you don't have to enable 
> SMP in kernel to do multithreading ? 

Lest anyone think me completely clueless, yes, I'm well aware of that.  It's
just that I wanted to have that warm fuzzy feeling the comes from pretending I
had the cash to buy a dual processor machine when I bought this PC.

I had planned too, but my laptop died and I needed a new box in a hurry so I had
to get what I could get.  It's a decent motherboard though, for being single
processor.

On the other hand, I did identify that you can't power off with smp enabled
unless (as someone helpfully posted) you give this parameter in lilo or grub:

apm=power-off

While the SMP config option says APM doesn't work if you have SMP enabled (so I
should have known), it would be helpful to mention that you can still power off
this way.

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
