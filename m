Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSKUWuN>; Thu, 21 Nov 2002 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKUWsz>; Thu, 21 Nov 2002 17:48:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:51915 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265262AbSKUWsw>;
	Thu, 21 Nov 2002 17:48:52 -0500
Message-ID: <3DDD6473.95F8F4C6@digeo.com>
Date: Thu, 21 Nov 2002 14:55:47 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roland Schwarz <webmaster@rolandschwarz.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interrupts problem with 3com network cards on dual-cpu systems ?
References: <NNEIJAEFFFIEBKPOMOJFAEKDDLAA.webmaster@rolandschwarz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 22:55:47.0299 (UTC) FILETIME=[2141BB30:01C291B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Schwarz wrote:
> 
> Hi kernel-hackers out there ! :-)
> 
> Maybe someone of you can help me with a problem I have here with three
> computers and Linux. Okay, three computers, all of them are DualCPU systems.
> 
> 1. P2-300 dual, 256 megs of ram
> 
> 2. P2-400 dual, 512 megs ram
> 
> 3. P3-800 dual . 1 GB ram .
> 
> All computers use 3com network cards ( 3C95x ) , number one has two, this is
> my gateway//firewall computer. As Distribution I currently use Suse Linux
> 8.1, kernel version 2.4.19-64 GB. Firewall is iptables.
> 
> The problem I encounter is a errormessage from the Linuxkernel going like
> this:
> 
> ethx : interrupt postet but not delivered
> ethx : resetting tx-ring pointer ( several times repeated )
> 

Try adding `noapic' to the kernel boot commandline.
