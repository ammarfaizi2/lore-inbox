Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUB2LJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 06:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUB2LJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 06:09:17 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:41409 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262030AbUB2LJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 06:09:16 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Date: Sun, 29 Feb 2004 11:09:15 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <4041C85B.30333.2D21C847@localhost>
In-reply-to: <87llmmtihe.fsf@devron.myhome.or.jp>
References: <87vflqtiz6.fsf@devron.myhome.or.jp>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Umm.. Looks like chip registers is normal, but TX/RX interrupt doesn't
> > happen. (BTW, there isn't rtl8139_open on debuginfo.txt. Was it already
> > scrolled?)
> > 
> > The following patch (incremental patch) is some part reverts to
> > 2.6.2. Is behavior changed?
> 
> Oops, wrong patches. Please try these.

OK, I applied patch01 first - same problems.  Then I applied patch02 
_over_ patch01.  Still same results.

I am not sure if you meant me to apply over the first debug patch you 
sent?  Here, I just applied to standard 2.6.3 > 8139too.c file with 
RTL8139_NDEBUG 1 set.

With these patched dmesg gets flooded - and I have real trouble 
trying to do anything on the box with the timeout issues.

http://www.linicks.net/8139too_debug/patch01_02_info.txt

Thanks,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
