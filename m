Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWIIXdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWIIXdS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWIIXdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:33:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37555 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965014AbWIIXdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:33:17 -0400
Subject: Re: Driver - cfag12864b Crystalfontz 128x64 2-color Graphic LCD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <653402b90609091614p371dc60ub7c52d0910cf106@mail.gmail.com>
References: <653402b90609081010k19598ce7ta1f64f3060ad4700@mail.gmail.com>
	 <1157818217.6877.56.camel@localhost.localdomain>
	 <653402b90609091614p371dc60ub7c52d0910cf106@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 00:56:26 +0100
Message-Id: <1157846186.6877.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-10 am 01:14 +0200, ysgrifennodd Miguel Ojeda:
> parport_register_device() "The PARPORT_DEV_EXCL flag is for preventing
> port sharing, and so should only be used when sharing the port with
> other device drivers is impossible and would lead to incorrect
> behaviour. Use it sparingly!"

This is the one you want. It's there for things like parallel port
quickcams.

> Ok, easier that way. In fact, the conversion function takes just 20
> lines... I can provide it as an example with the driver. Is the
> Documentation/* the right place?

If its only 20 lines why not, in fact if its that short it might be fine
in kernel too.


