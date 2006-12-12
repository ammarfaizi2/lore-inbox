Return-Path: <linux-kernel-owner+w=401wt.eu-S1750836AbWLLBgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWLLBgq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWLLBgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:36:46 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35984
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750836AbWLLBgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:36:45 -0500
Date: Mon, 11 Dec 2006 17:36:44 -0800 (PST)
Message-Id: <20061211.173644.130208821.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061128192236.GA2051@2ka.mipt.ru>
References: <20061128091602.GC15083@2ka.mipt.ru>
	<20061128.111300.105813754.davem@davemloft.net>
	<20061128192236.GA2051@2ka.mipt.ru>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Tue, 28 Nov 2006 22:22:36 +0300

> And, btw, last time I checked, aligned_u64 was not exported to
> userspace.

It is in linux/types.h and not protected by __KERNEL__ ifdefs.
Perhaps you mean something else?
