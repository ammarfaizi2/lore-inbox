Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUCBV0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUCBV0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:26:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:8882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261822AbUCBV0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:26:08 -0500
Date: Tue, 2 Mar 2004 13:27:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: George Anzinger <george@mvista.com>
Cc: amitkale@emsyssoft.com, ak@suse.de, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040302132751.255b9807.akpm@osdl.org>
In-Reply-To: <4044F84D.4030003@mvista.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<200402061914.38826.amitkale@emsyssoft.com>
	<403FDB37.2020704@mvista.com>
	<200403011508.23626.amitkale@emsyssoft.com>
	<4044F84D.4030003@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
>  Often it is not clear just why we are in the stub, given that 
> we trap such things as kernel page faults, NMI watchdog, BUG macros and such.

Yes, that can be confusing.  A little printk on the console prior to
entering the debugger would be nice.
