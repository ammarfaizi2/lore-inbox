Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSLFNwM>; Fri, 6 Dec 2002 08:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSLFNwM>; Fri, 6 Dec 2002 08:52:12 -0500
Received: from blackhole.kfki.hu ([148.6.0.114]:34822 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id <S262317AbSLFNwL>;
	Fri, 6 Dec 2002 08:52:11 -0500
Date: Fri, 6 Dec 2002 14:59:46 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: jpiszcz <jpiszcz@lucidpixels.com>
Cc: <netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Question with printk warnings in ip_conntrack with 2.4.20.]
In-Reply-To: <3DEFE07D.4020909@lucidpixels.com>
Message-ID: <Pine.LNX.4.33.0212061448500.2648-100000@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, jpiszcz wrote:

> Stange?  I am just using vcheck (perl script) that goes out and checks
> out software for the latest versions.

If the script uses active mode FTP and when that is refused by the server
reverts back to passive mode, that is a natural explanation for such log
entries.

Could you record by tcpdump at least one such FTP session?

> Will there possibly be a /proc or kernel config option for warnings such
> as these?

In my opinion a new directory tree /proc/sys/net/ipv4/netfilter is
required so that tuning options could be easily added to the system.
But that implies backward (in)compatibily issues...

Regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary

