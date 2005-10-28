Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVJ1OkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVJ1OkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVJ1OkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:40:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030197AbVJ1OkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:40:17 -0400
Date: Fri, 28 Oct 2005 07:40:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Boxer Gnome <aiko.sex@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: boot ok,but reboot hang, from 2.6.10 to 2.6.14
In-Reply-To: <174467f50510280544g5fffdfaeq@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510280733000.4664@g5.osdl.org>
References: <174467f50510280544g5fffdfaeq@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Oct 2005, Boxer Gnome wrote:
> 
> This only happens in reboot from linux kernel within 2.6.10-2.6.14.
> 
> I tested the older kernel version from 2.6.8 to 2.6.14,and 2.4.31 .I
> found the 2.6.8 and the 2.6.9,2.4.31 worked well without above
> reboot_from_linux_with_hang_after_POST,and the 2.6.10-2.6.14 all have
> this.

Can you try to pinpoint when it started happening more closely?

The differences between 2.6.9 and 2.6.10 are pretty big, and it would be 
much better if you can pinpoint it to a smaller range.

You can find three "release candidates" for 2.6.10 in

	http://www.kernel.org/pub/linux/kernel/v2.6/testing

and if you first test 2.6.10-rc2, and then depending on whether that 
already has the bug or not, you'd test 2.6.10-rc1 or 2.6.10-rc2. That 
would help pinpoint the difference to between two particular -rc kernels, 
which would be much better.

After that, I might end up still asking you to test one or two daily 
snapshots, but it may be that pinpointing when your reboot troubles 
started to just the -rc kernel might be good enough.

		Linus
