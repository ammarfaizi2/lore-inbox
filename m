Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTH0U7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 16:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTH0U7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 16:59:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262796AbTH0U71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 16:59:27 -0400
Date: Wed, 27 Aug 2003 16:59:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jason Baron <jbaron@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.22
In-Reply-To: <Pine.LNX.4.53.0308271139380.697@chaos>
Message-ID: <Pine.LNX.4.53.0308271650350.143@chaos>
References: <Pine.LNX.4.44.0308271127150.1491-100000@dhcp64-178.boston.redhat.com>
 <Pine.LNX.4.53.0308271139380.697@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Richard B. Johnson wrote:

> On Wed, 27 Aug 2003, Jason Baron wrote:
>
> >
> > On Tue, 26 Aug 2003, Richard B. Johnson wrote:
> >
> > >
> > > I configured, built and booted Linux-2.4.22. There are
> > > some problems.
> > >
> > > (1) `dmesg` fails to read the first part of the buffered
> > > kernel log. I have attached two files, dmesg-20 (normal)
> >
> > sounds like the log buffer wrapped around from a lot of printks
> >
>

I looked into this. The problem I am seeing is not in printk().
It may, therefore, be in klogd.

I replaced the linux-2.4.22 printk() with the one that worked from
2.4.20. The problem presists!

The log-file, when booting the SMP machine is 7,653 bytes when
using 2.4.20. With linux-2.4.22, the first 33 bytes are missing.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


