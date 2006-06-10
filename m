Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWFJF3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWFJF3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFJF3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:29:15 -0400
Received: from quechua.inka.de ([193.197.184.2]:21163 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932362AbWFJF3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:29:14 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.64.0606100245130.12765@mercury.sdinet.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fow24-0000Qb-00@calista.eckenfels.net>
Date: Sat, 10 Jun 2006 07:29:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Haegar Koch <haegar@sdinet.de> wrote:
> I see a different problem with "ext3 + extends is not ext3 anymore" when 
> the feature goes mainstream:
> - user with old distri, no extends in use, no kernel support for them
> - user has some kind of problem
> - uses new rescue disk (aka knoppix at the time of problem) - that then
>   is current stuff, and certainly uses extents - fixes problem on disk
>   (may be a simple as running lilo/grub from chroot, happens often for me)
> - tries to boot back into his distri -> *boom* he lost

I dont see a need to enable extends on small filesystems or on existing ones
(from within any tool). Why would that happen? Do you had this problem with
sparse_super or dir_index?

Gruss
Bernd
