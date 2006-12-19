Return-Path: <linux-kernel-owner+w=401wt.eu-S932892AbWLSSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbWLSSss (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLSSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:48:48 -0500
Received: from www.osadl.org ([213.239.205.134]:59873 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932892AbWLSSsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:48:47 -0500
Subject: Re: BUG: NMI Watchdog detected LOCKUP (was: 2.6.20-rc1-mm1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tilman Schmidt <tilman@imap.cc>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200612191815.kBJIFF4O018306@lx1.pxnet.com>
References: <20061214225913.3338f677.akpm@osdl.org>
	 <200612191815.kBJIFF4O018306@lx1.pxnet.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 19:52:57 +0100
Message-Id: <1166554377.29505.450.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 22:59 -0800, Tilman Schmidt wrote:
>  [<c021d049>] rb_insert_color+0x55/0xbe
>  [<c012d15b>] enqueue_hrtimer+0x10a/0x116
>  [<c012d9b4>] hrtimer_start+0x78/0x93
>  [<c0123453>] get_signal_to_deliver+0xf3/0x74e
>  [<c01026ee>] do_notify_resume+0x93/0x655
>  [<c0102ef5>] work_notifysig+0x13/0x1a
>  [<b7f5f410>] 0xb7f5f410

Not really helpful.

> Config file available upon request. (The system won't boot right now,
> it wants a manual fsck first.) Bisecting this promises to take about
> 8 hours per iteration if I add up the wait for the hang, the fsck
> afterwards and the time this system needs for compiling a kernel, so
> I'll wait for you to tell me if it's really necessary. ;-)

Can you send me the config file please and the boot log of the machine ?

	tglx


