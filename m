Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUBTQmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUBTQmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:42:15 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:20116 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261309AbUBTQmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:42:14 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 20 Feb 2004 16:42:11 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems
Message-ID: <403638E3.7864.9E7B698@localhost>
In-reply-to: <40353D2C.2050406@pobox.com>
References: <4034E88C.24740.4C5D4B6@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux233 kernel: NETDEV WATCHDOG: eth1: transmit timed out
> > Linux233 kernel: eth1: link up, 10Mbps, half-duplex, lpa 0x0000
> > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Linux233 kernel: nfs: server 486Linux OK
> > Linux233 kernel: nfs: server 486Linux OK
> > Linux233 kernel: nfs: server 486Linux not responding, still trying
> > Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Linux233 kernel: nfs: server 486Linux OK
> 
> 
> This is usually irq routing related...  Try booting with 'noapic' or 
> similar.

I don't have apic built in the kernel.  This has only started to 
happen on 2.6.3.  As I said, on all other kernels, 2.4.x, 2.6.0, 
2.6.1, 2.6.2 these NIC are OK.

With 2.6.3 my logs are now riddled with these messages (and the 
period is totally random - sometimes 10 times in an hour), and I lose 
connectivity during these periods.

I will be booting back into 2.6.2 tonight until I can resolve this.

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

