Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276721AbRJBV42>; Tue, 2 Oct 2001 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276725AbRJBV4T>; Tue, 2 Oct 2001 17:56:19 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4700 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276721AbRJBV4D>; Tue, 2 Oct 2001 17:56:03 -0400
Date: Tue, 2 Oct 2001 17:56:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110022156.f92LuXo06743@devserv.devel.redhat.com>
To: captainsmp@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: sock_sendmsg() from a kernel thread question
In-Reply-To: <mailman.1002057181.10060.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1002057181.10060.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to call sock_sendmsg() from a kernel thread
> and it seems to work fine on a UP system but on SMP system
> it hangs up and the thread can't even accept a SIGKILL.
> It it stuck after the following calls happen:
> 
> sock_sendmsg()
> sock->ops->sendmsg()
> tcp_do_sendmsg()

Always worked fine for me. I think something is up with
your code. Care to post a relevant snippet?

-- Pete
