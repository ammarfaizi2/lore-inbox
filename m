Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUKWOrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUKWOrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKWOpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:45:08 -0500
Received: from alog0095.analogic.com ([208.224.220.110]:26240 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261275AbUKWOnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:43:12 -0500
Date: Tue, 23 Nov 2004 09:42:20 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Running Ethernet without ARP
In-Reply-To: <20041123140025.GA32447@beton.cybernet.src>
Message-ID: <Pine.LNX.4.61.0411230937140.4513@chaos.analogic.com>
References: <20041123140025.GA32447@beton.cybernet.src>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Karel Kulhavy wrote:

> Hello
>
> man netdevice says:
> "IFF_NOARP	No arp protocol, L2 deswtination address not set".
> Is it possible to run ptp Ethernet link between two Linux routers this
> way? I would like to run the link with two constraints:
> 1) no ARP protocol used
> 2) The link should continue to work even if root access to one computer is
> inaccessible and the NIC in the other one is replaced without changing
> it's MAC (for example because it doesn't support MAC change)
>
> Cl<

ARP means address resolution protocol. That's how one machine
learns about the MAC (Hardware) address of another so it can
communicate with it. Without ARP, you need to send / receive
broadcast packets (Like M$ Netboius). This means that everything
is received by everyone on the LAN and needs to be dumped on
the floor by everybody except the intended target.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
