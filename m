Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRDJXDN>; Tue, 10 Apr 2001 19:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132472AbRDJXCx>; Tue, 10 Apr 2001 19:02:53 -0400
Received: from meatloop.andover.net ([209.192.217.120]:5762 "HELO
	meatloop.andover.net") by vger.kernel.org with SMTP
	id <S132468AbRDJXCm>; Tue, 10 Apr 2001 19:02:42 -0400
Date: Tue, 10 Apr 2001 19:01:16 -0400 (EDT)
From: Dave <daveo@osdn.com>
X-X-Sender: <count@meatloop.andover.net>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: bizarre TCP behavior
In-Reply-To: <20010410185618.C14377@xi.linuxpower.cx>
Message-ID: <Pine.LNX.4.33.0104101900240.1940-100000@meatloop.andover.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This did fix my problem.  Thanks very much, I'll be sure to send a polite
message to the admins at sites where I notice this problem!  Any detailed
info you might have on why this was failing?
	dave

---

This is my signature.  There are many like it but this one is mine.

On Tue, 10 Apr 2001, Gregory Maxwell wrote:

> On Tue, Apr 10, 2001 at 06:24:46PM -0400, Dave wrote:
> > I am having a very strange problem in linux 2.4 kernels.  I have not set
> > any iptables rules at all, and there is no firewall blocking any of my
> > outgoing traffic.  At what seems like random selection, I can not connect
> > to IP's yet I can get ping replies from them.  Most IP's reply just fine,
> > but certain ones fail to send even an ACK.  This problem disappears when I
> > boot into 2.2.  Here is a brief example of what I am talking about:
>
> echo -n 0 > /proc/sys/net/ipv4/tcp_ecn
>
> Fix it?
>
> If so, please tell the sites your are trying to connect to to upgrade their
> $I#$@#%@(%)@%$ firewall and/or loadbalencer (usually Localdirector or PIX).
>
>

