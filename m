Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSBDKv1>; Mon, 4 Feb 2002 05:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSBDKvR>; Mon, 4 Feb 2002 05:51:17 -0500
Received: from deepthought.blinkenlights.nl ([62.58.162.228]:8708 "EHLO
	deepthought.blinkenlights.nl") by vger.kernel.org with ESMTP
	id <S288878AbSBDKvD>; Mon, 4 Feb 2002 05:51:03 -0500
Date: Mon, 4 Feb 2002 11:58:10 +0100 (CET)
From: Sten <sten@blinkenlights.nl>
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org,
        HP900 PARISC mailing list 
	<parisc-linux@lists.parisc-linux.org>
Subject: Re: IPv6 Sparc64
In-Reply-To: <Pine.NEB.4.33.0202041002120.2571-100000@www2.scram.de>
Message-ID: <Pine.LNX.4.44-Blink.0202041155020.19625-100000@deepthought.blinkenlights.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, Jochen Friedrich wrote:

> > I have been trying to get ipv6 to work
> > on sparc64/kernel 2.4 but it looks like it
> > is broken somewhere in the kernel.
> > I was wondering if this was a known problem.
>
> > [root@towel ip]# ping6 ::1
> > PING ::1(::1) from ::1 : 56 data bytes
>
> It's the same on PARISC. However, on PARISC, although ping6 doesn't work,
> telnet etc do work, as well as pinging the PARISC box from an Intel or
> Alpha machine.

The reason I ask this is because I have been trying to setup a
tunnel, and I cant get it to work either with ifconfig or iproute.

[root@towel ip]# ip tunnel add blink mode sit remote x.x.x.x dev
eth0
ioctl: Invalid argument

-- 
Sten Spans

  "What does one do with ones money,
   when there is no more empty rackspace ?"

