Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVLaLAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVLaLAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVLaLAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:00:49 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:26760 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932140AbVLaLAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:00:48 -0500
Date: Sat, 31 Dec 2005 12:00:50 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231120050.21e6aeae@localhost>
In-Reply-To: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
References: <200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 09:13:24 +0100
Mike Galbraith <efault@gmx.de> wrote:

> Ingo seems to have done something in 2.6.15-rc7-rt1 which defeats your 
> little proggy.  Taking a quick peek at the rt scheduler changes, nothing 
> poked me in the eye, but by golly, I can't get this kernel to act up, 
> whereas 2.6.14-virgin does.

Mmm... I get an infinite list of init segfaults trying to boot it. I've
tried disabling CONFIG_CC_OPTIMIZE_FOR_SIZE but it didn't help.

I'll try later with a simplier ".config".

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
