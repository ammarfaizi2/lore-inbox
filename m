Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUCNSv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUCNSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:51:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:51584 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261467AbUCNSvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:51:52 -0500
X-Authenticated: #1226656
Date: Sun, 14 Mar 2004 19:52:03 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-Id: <20040314195203.78abbef9@vaio.gigerstyle.ch>
In-Reply-To: <20040314170627.A11159@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
	<20040312182754.A680@jurassic.park.msu.ru>
	<20040312184115.B680@jurassic.park.msu.ru>
	<20040312165907.626d4a08@hdg.gigerstyle.ch>
	<20040312224649.A750@den.park.msu.ru>
	<20040312215215.1041889a@hdg.gigerstyle.ch>
	<20040313020141.B4021@den.park.msu.ru>
	<20040313111021.4af73b9e@hdg.gigerstyle.ch>
	<20040314170627.A11159@den.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On Sun, 14 Mar 2004 17:06:27 +0300
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Sat, Mar 13, 2004 at 11:10:21AM +0100, Marc Giger wrote:
> > Hmm, I couldn't boot the kernel with enabled "semaphore debugging".
> > It hangs directly after aboot. No messages, nothing. Do I something
> > wrong?
> 
> No. Indeed, "semaphore debugging" is completely useless since printk()
> itself is trying to acquire the console_sem, which in turn causes
> another debugging printk() and so on.
> I think this option should be removed...
> 
> > Now I've booted 2.6.4 without debugging.
> 
> And does the last patch makes things better?

No, it doesn't. After some hours it has got the same problems.

It's interesting that this happens after some hours of uptime and not
immediately.

Regards

Marc
