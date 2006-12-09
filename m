Return-Path: <linux-kernel-owner+w=401wt.eu-S1758366AbWLIVt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758366AbWLIVt2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758397AbWLIVt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:49:28 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59584
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758366AbWLIVt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:49:27 -0500
Date: Sat, 09 Dec 2006 13:49:28 -0800 (PST)
Message-Id: <20061209.134928.78719042.davem@davemloft.net>
To: tgraf@suug.ch
Cc: stefan@loplof.de, drow@false.org, dwmw2@infradead.org,
       joseph@codesourcery.com, netdev@vger.kernel.org,
       libc-alpha@sourceware.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [NETLINK]: Schedule removal of old macros exported to userspace
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061209125533.GO8693@postel.suug.ch>
References: <20061209103953.GN8693@postel.suug.ch>
	<200612091249.39302.stefan@loplof.de>
	<20061209125533.GO8693@postel.suug.ch>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Graf <tgraf@suug.ch>
Date: Sat, 9 Dec 2006 13:55:33 +0100

> The point is to stop new applications from using the interface which has
> resulted in buggy code in the past.

You don't get people to use new interface by breaking the
build on them in userspace.

You get them to do it by making suggestions and informing them, not
by forcing them.

That's why 1) you can't get rid of these macros, ever, but 2) you can
warn them by using inline functions and depcrecated attribute tags.
