Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbVJ1VUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbVJ1VUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbVJ1VUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:20:41 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43685 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751809AbVJ1VUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:20:40 -0400
Date: Fri, 28 Oct 2005 23:20:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Pavel Machek <pavel@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
In-Reply-To: <20051028205916.GL4464@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0510282319460.20866@yvahk01.tjqt.qr>
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz>
 <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com>
 <1130532239.4363.125.camel@mindpipe> <20051028205132.GB11397@elf.ucw.cz>
 <20051028205916.GL4464@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Well, keyboard detected and reported an error. Kernel reacted with
>> printk(). You are removing that printk(). I can understand that,
>> printk is really annoying, but I really believe _some_ error handling
>> should be added there if you remove the printk.
>
>What do you suggest?

I would say print it once a day, or even less, e.g. once per boot.

>Having a TP 380XD which regularly produces this annoying message,
>it's just logspam.  There's no noticable failure.


Jan Engelhardt
-- 
