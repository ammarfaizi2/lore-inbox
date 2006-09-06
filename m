Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWIFFi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWIFFi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 01:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWIFFiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 01:38:25 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:52448 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932361AbWIFFiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 01:38:24 -0400
Date: Wed, 6 Sep 2006 07:38:06 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Om Narasimhan <om.turyx@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: howto map HDT dumped addresses to AMD64 kernel virtual addresses.
In-Reply-To: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0609060737350.6300@yvahk01.tjqt.qr>
References: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
> I am running a kernel (Suse Enterprise 9 with SP3) and it is hanging
> somewhere in the kernel. By hooking up HDT from AMD, I got a the
> assembly dump of the routine which causes the infinite loop. How

As long as interrupts are not disabled, sysrq+t should show you the EIP 
where it loops.

> should I map the addresses dumped by HDT in the format SEG:Offset
> (e.g,
> 0033:00000000_00400C18   mov   esi,[loc_0000000000501a64h]
> 0033:00000000_00400C1E   test   esi,esi
> 0033:00000000_00400C20   jz   loc_0000000000400c30h
> ...etc)
> to kernel virtual address space?


Jan Engelhardt
-- 
