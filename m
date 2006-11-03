Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752654AbWKCJEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbWKCJEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 04:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbWKCJEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 04:04:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53678
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752629AbWKCJEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 04:04:11 -0500
Date: Fri, 03 Nov 2006 01:04:13 -0800 (PST)
Message-Id: <20061103.010413.85690195.davem@davemloft.net>
To: pavel@ucw.cz
Cc: johnpol@2ka.mipt.ru, nate.diller@gmail.com, linux-kernel@vger.kernel.org,
       olecom@flower.upol.cz, drepper@redhat.com, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org,
       chase.venters@clientec.com, johann.borck@densedata.com
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061103085712.GA3725@elf.ucw.cz>
References: <5c49b0ed0611021140u360342f2v1e83c73d03eea329@mail.gmail.com>
	<20061103084240.GB1184@2ka.mipt.ru>
	<20061103085712.GA3725@elf.ucw.cz>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 3 Nov 2006 09:57:12 +0100

> Not sure what you are smoking, but "there's unsigned long in *bsd
> version, lets rewrite it from scratch" sounds like very bad idea. What
> about fixing that one bit you don't like?

I disagree, it's more like since we have to be structure incompatible
anyways, let's design something superior if we can.

