Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVJ2C04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVJ2C04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVJ2C0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:26:55 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:41751 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751092AbVJ2C0z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:26:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N3OYId6oNbdEXvD3kI0kPlCZ+qgvA/RcgQfXAubaYx+Fzdayph4+nIp3SpBZPYOO6u2lmdlxAc/CYbh3+hskxGm7Y9xNZFpgWfSsgvzxEFwwxQya+af1wqmPKGi5ZgfOgHKQ2ntyP5N1SY+ftCHzG3Bxl1/puIVA1c6LFNnuMQc=
Message-ID: <174467f50510281926tfcbcc4bi@mail.gmail.com>
Date: Sat, 29 Oct 2005 10:26:54 +0800
From: Boxer Gnome <aiko.sex@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: boot ok,but reboot hang, from 2.6.10 to 2.6.14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510280733000.4664@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <174467f50510280544g5fffdfaeq@mail.gmail.com>
	 <Pine.LNX.4.64.0510280733000.4664@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/10/28, Linus Torvalds <torvalds@osdl.org>:
>
>
> On Fri, 28 Oct 2005, Boxer Gnome wrote:
> >
> > This only happens in reboot from linux kernel within 2.6.10-2.6.14.
> >
> > I tested the older kernel version from 2.6.8 to 2.6.14,and 2.4.31 .I
> > found the 2.6.8 and the 2.6.9,2.4.31 worked well without above
> > reboot_from_linux_with_hang_after_POST,and the 2.6.10-2.6.14 all have
> > this.
>
> Can you try to pinpoint when it started happening more closely?
>
> The differences between 2.6.9 and 2.6.10 are pretty big, and it would be
> much better if you can pinpoint it to a smaller range.
>
> You can find three "release candidates" for 2.6.10 in
>
>        http://www.kernel.org/pub/linux/kernel/v2.6/testing
>
> and if you first test 2.6.10-rc2, and then depending on whether that
> already has the bug or not, you'd test 2.6.10-rc1 or 2.6.10-rc2. That
> would help pinpoint the difference to between two particular -rc kernels,
> which would be much better.
>
> After that, I might end up still asking you to test one or two daily
> snapshots, but it may be that pinpointing when your reboot troubles
> started to just the -rc kernel might be good enough.
>
>                Linus
>
I tested the 2.6.10-rc1 and 2.6.10-rc2,the 2.6.10-rc1 rebooted ok,but
the 2.6.10-rc2 has that problem.

Then I test the snapshot
2.6.10-rc2-bk1,2.6.10-rc2-bk4,2.6.10-rc2-bk8,they all have this reboot
hang.

SO,I think the 2.6.10-rc1 is the last worked ok version.



Thanks
