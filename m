Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUBSWs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUBSWs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:48:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60571 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267403AbUBSWsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:48:25 -0500
Message-ID: <40353D2C.2050406@pobox.com>
Date: Thu, 19 Feb 2004 17:48:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Warne <nick@ukfsn.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 RT8139too NIC problems
References: <4034E88C.24740.4C5D4B6@localhost>
In-Reply-To: <4034E88C.24740.4C5D4B6@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> Hello all,
> 
> Due to traffic restraints, I am not on the lkml - please CC replies.
> 
> Yesterday I built 2.6.3.  Clean build, and system runs nice.
> 
> I have two NIC's in the box, both rt8139.
> 
> But I noticed I am getting this in syslogs:
> 
> Linux233 kernel: NETDEV WATCHDOG: eth1: transmit timed out
> Linux233 kernel: eth1: link up, 10Mbps, half-duplex, lpa 0x0000
> Linux233 kernel: nfs: server 486Linux not responding, still trying
> Linux233 kernel: nfs: server 486Linux not responding, still trying
> Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Linux233 kernel: nfs: server 486Linux OK
> Linux233 kernel: nfs: server 486Linux OK
> Linux233 kernel: nfs: server 486Linux not responding, still trying
> Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Linux233 kernel: nfs: server 486Linux OK


This is usually irq routing related...  Try booting with 'noapic' or 
similar.

	Jeff



