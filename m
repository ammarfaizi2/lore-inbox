Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbULRQG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbULRQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 11:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbULRQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 11:06:56 -0500
Received: from customers.imt.ru ([212.16.0.33]:51767 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id S261160AbULRQGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 11:06:54 -0500
Date: Sat, 18 Dec 2004 19:07:42 +0300
From: Crazy AMD K7 <snort2004@mail.ru>
X-Mailer: The Bat! (v1.46d)
Reply-To: Crazy AMD K7 <snort2004@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1421293830.20041218190742@mail.ru>
To: Andi Kleen <ak@suse.de>
CC: Bart De Schuymer <bdschuym@pandora.be>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re[2]: do_IRQ: stack overflow: 872..
In-reply-To: <20041218135320.GA10030@wotan.suse.de>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
 <p73zn0ccaee.fsf@verdi.suse.de>
 <1103368330.3566.15.camel@localhost.localdomain>
 <20041218111420.GE338@wotan.suse.de>
 <1103370690.3566.33.camel@localhost.localdomain>
 <20041218135320.GA10030@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note to the original poster: when you report a bug with a patched
> kernel always mention it.
I have mentioned earlier and Bart knows it.

I use 2.4.28
+ ebtables-brnf-8_vs_2.4.28.diff
+ U32 patch from patch-o-matic-ng-20040621.tar.bz2
+ patch for br_netfilter.c made by Bart to find out why kernel panic happens(it was a few
  letters ago)
  All patches has applies cleanly.
  U32 doesn't affect on br_netfilter.c

[root@linux kernel]# md5sum linux-2.4.28.tar.bz2
ac7735000d185bc7778c08288760a8a3  linux-2.4.28.tar.bz2
(taken from http://www.ru.kernel.org/pub/linux/kernel/v2.4/linux-2.4.28.tar.bz2)

[root@linux bridge]# md5sum ebtables-brnf-8_vs_2.4.28.diff.gz
30542b1a7a502593afb4d37055ec5e35  ebtables-brnf-8_vs_2.4.28.diff.gz

[root@linux iptables]# md5sum patch-o-matic-ng-20040621.tar.bz2
4fd3c744bf55f119fef6c7c3c4acc4b6  patch-o-matic-ng-20040621.tar.bz2

If the problem will continue appear and will not be solved an any
way, of course, I will use 2.6 kernel, now I am not ready to use it.

Pasha


