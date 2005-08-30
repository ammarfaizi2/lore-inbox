Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVH3Ix3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVH3Ix3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVH3Ix3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:53:29 -0400
Received: from newton.linux4geeks.de ([193.30.1.1]:62085 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S1751276AbVH3Ix2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:53:28 -0400
Date: Tue, 30 Aug 2005 10:53:13 +0200 (CEST)
From: Sven Ladegast <sven@linux4geeks.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
In-Reply-To: <20050830082901.GA25438@bitwizard.nl>
Message-ID: <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
 <20050830082901.GA25438@bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Rogier Wolff wrote:

> It IS some "home phoning" and "spy software". However, when the
> goal is to sign you up for more direct marketing, people tend to
> object. When the goal is to keep track of running kernels, I'm
> hopeful that people will recognise that this is different.

The problem is that people made bad experiences with home-phoning software 
in the past. Changing their opinion about this issue isn't easy I think.
I can almost see the headlines: Spy software found in recent Linux 
kernels... :o)

Although home-phoning can be useful under certain circumstances it is the 
wrong way to implement it in a kernel. IMHO a userspace tool is the better 
solution: Everyone can decide if he/she wants to report what kernel 
version is running on their systems.

> A trick to use would be to send an UDP packet at boot (after 1 minute
> or so), and then randomly say "once a month" (i.e. about 1/30 chance of
> sending a packet on the first day) The number of these random packets
> recieved is a measure of the number of CPU-months that the kernel
> runs.

This could be a sloution but like you know UDP packets may or may not 
arrive the destination address. So the packet loss with this method could 
be very high, expecially if you send only one packet. Using a 
TCP-connection for this is a lot more stable and the payload can be 
encrypted too.

Once again: I think this is a userspace task.

Sven

