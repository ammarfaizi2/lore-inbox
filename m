Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSCMAds>; Tue, 12 Mar 2002 19:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291394AbSCMAdi>; Tue, 12 Mar 2002 19:33:38 -0500
Received: from quechua.inka.de ([212.227.14.2]:2856 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S291340AbSCMAd0>;
	Tue, 12 Mar 2002 19:33:26 -0500
From: Bernd Eckenfels <ecki-news2002-02@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
In-Reply-To: <3C8E7E08.C3CF4227@us.ibm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16kwhr-0003Nb-00@sites.inka.de>
Date: Wed, 13 Mar 2002 01:33:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C8E7E08.C3CF4227@us.ibm.com> you wrote:
> Please be clear that this is NOT intended to replace printk and
> syslog, but to coexist with them and provide additional 
> capabilities not available with printk/syslog that are highly 
> desirable in large servers and Telecom environments (to name a few).

Thinks I could think of, which produce a large amount are iptables logs, audit
messages and network debug logs like rejected packets, discarded packages due
to checksum failures, route changes, interface changes, etc.

Of course it is only useful if it is not another framework because this will
lead to kernel clutter. So do we want to replace netlink and printk?

Greetings
Bernd
