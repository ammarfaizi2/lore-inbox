Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136254AbRAWH3G>; Tue, 23 Jan 2001 02:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136282AbRAWH25>; Tue, 23 Jan 2001 02:28:57 -0500
Received: from [203.36.158.121] ([203.36.158.121]:26497 "EHLO kabuki.eyep.net")
	by vger.kernel.org with ESMTP id <S136254AbRAWH2q>;
	Tue, 23 Jan 2001 02:28:46 -0500
Subject: Re: Firewall netlink question...
From: Daniel Stone <daniel@kabuki.eyep.net>
To: scaramanga@barrysworld.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010122115826.A11297@lemsip.lan>
In-Reply-To: <20010122073343.A3839@lemsip.lan>  
	<Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de>  
	<20010122102600.A4458@lemsip.lan> <E14Kf9W-0008PJ-00@kabuki.eyep.net>  
	<20010122115826.A11297@lemsip.lan>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 23 Jan 2001 18:33:48 +1100
Mime-Version: 1.0
Message-Id: <E14Kxxd-0000LD-00@kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2001 11:58:26 +0000, Scaramanga wrote:
> Hi,
> >> What was wrong with the firewall netlink? My re-implementation works great
> >> here. I can't see why anything else would be needed, QUEUE seems twice as
> >> complex. Unless with QUEUE the userspce applications can make decisions on
> >> what to do with the packet? In which case, it would be far too inefficient
> >> for an application like mine, where all i need is to be able to read the
> >> IP datagrams..
> > 
> > It can modify and then reinject the packet if it so wishes.
> 
> Excellent, I didn't pick up on that, with the cursory glance at the code i took.
> 
> I wonder, would there be any interest/point in my NETLINK module, which
> provides a backward compatible netlink interface. There are a good few
> apps out there which rely on it, and its nice not to have to run a daemon
> and install a new library, and re-write them just to continue using them...

This is a great idea.
Seeing as we have the compatability for ipchains and ipfwadm, this can't
be an altogether thing. Plus, userspace hacks to detect kernel versions
are always bad.

> egg.microsoft.com: Remote operating system guess: Solaris 2.6 - 2.7

My all-time favourite is Microsoft-IIS/4.0 (Unix) mod_ssl/2.<whatever>
OpenSSL/0.9.4

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
