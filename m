Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275068AbTHGFZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275073AbTHGFZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:25:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:10932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275068AbTHGFZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:25:36 -0400
Message-ID: <32841.4.4.25.4.1060233933.squirrel@www.osdl.org>
Date: Wed, 6 Aug 2003 22:25:33 -0700 (PDT)
Subject: Re: Newbie debugging question
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <mail@richardstevens.de>
In-Reply-To: <200308070230.49802.mail@richardstevens.de>
References: <200308070230.49802.mail@richardstevens.de>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I've been searching the net for quite some time now without success so I
> decided to ask the professionals. I'm looking for kernelhacker newbie
> friendly documentation on how to figure out a little more about a kernel
> lockup to be able to give the developer of a device driver some more info.

I suggest asking on the kernelnewbies mailing list (see kernelnewbies.org).
Also, some people started on this web page, but it's only a beginning:
  http://lse.sourceforge.net/debugging/

> The problem is that after a while the machine locks up with Caps Lock and
> Scroll lock blinking. I don't see any logs and no messages on the console. I
>  found some posts describing similar events and it was said that the kernel
> is  not completely dead in this state. Is there a way to get some more
> information? Where should I start reading.
>
> Please CC me since I'm not subscribed.

What kernel version?  That would have some effects on the answer.

Serial console is the usual option/route.  If it boots completely,
you could also try netconsole (or, dare I say it, usb console).
Or LKCD (lkcd.sf.net), or kmsgdump (2.5.75/2.6.0 at
http://www.xenotime.net/linux/kmsgdump/2.5.75/).

~Randy



