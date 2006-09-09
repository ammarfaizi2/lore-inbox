Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWIIPrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWIIPrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWIIPrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:47:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51346 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964784AbWIIPrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:47:10 -0400
Subject: Re: Driver - cfag12864b Crystalfontz 128x64 2-color Graphic LCD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <653402b90609081010k19598ce7ta1f64f3060ad4700@mail.gmail.com>
References: <653402b90609081010k19598ce7ta1f64f3060ad4700@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 17:10:17 +0100
Message-Id: <1157818217.6877.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-08 am 19:10 +0200, ysgrifennodd Miguel Ojeda:
> sure if it is the right approach. Should I use the parport interface
> to request and use the ports, or leave the driver as is?

The parport interface exists precisely to generalise these uses of the
parport.

> wait until you receive all the boolean matrix before the driver can
> start converting it to the cfag12864b format. If this makes no sense,
> please tell me, I will explain it further.

You usually want format conversion done in user space as it is more
flexible that way. X has all the right framework for this so you could
even have fun with X11 on it ;)

> 4. I would like to release the driver to the public, GPL'ed. Has it
> any possibility to enter in the mainstream kernel? Who can review it?
> ...?

A good place to start is kernelnewbies.org, and when you are happy with
it post it somewhere for more general review.

Alan

