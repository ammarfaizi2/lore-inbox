Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbULTXRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbULTXRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULTXPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:15:17 -0500
Received: from fsmlabs.com ([168.103.115.128]:34018 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261711AbULTXGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:06:14 -0500
Date: Mon, 20 Dec 2004 16:06:08 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Pavel Machek <pavel@suse.cz>, hugang@soulinfo.com,
       linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two
 stage V2.]
In-Reply-To: <20041220214443.GC13972@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0412201603500.12334@montezuma.fsmlabs.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz>
 <20041220214443.GC13972@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Nishanth Aravamudan wrote:

> > +		printk("\bdone (%li pages freed)\n", pages);
> > +		current->state = TASK_INTERRUPTIBLE;
> > +		schedule_timeout(HZ/5);
> 
> This should be msleep_interruptible() [I do not see any wait-queue events around
> this code].

'Gads! I hate to stalk you like this, but please trim your replies! =)
