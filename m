Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbREVQPo>; Tue, 22 May 2001 12:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbREVQPe>; Tue, 22 May 2001 12:15:34 -0400
Received: from [203.143.19.4] ([203.143.19.4]:24594 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262083AbREVQPS>;
	Tue, 22 May 2001 12:15:18 -0400
Date: Tue, 22 May 2001 01:09:34 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Nico Schottelius <nicos@pcsystems.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip.Blundell@pobox.com, tim@cyberelk.demon.co.uk,
        campbell@torque.net, andrea@e-mind.com, linux-parport@torque.net
Subject: Re: parport problems with devfs
In-Reply-To: <3B027E46.5095E8BB@pcsystems.de>
Message-ID: <Pine.LNX.4.21.0105220106480.325-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 May 2001, Nico Schottelius wrote:

> I attached the problem occured with parport and devfs. I don't exactly
> know where the problem in the parport source is. If someone has a
> patch for it, I will test it.
>
> [...]
> 
> # make our own device out of /dev
> flapp:/ # mknod /lp0 c 6 0
                  ^
You are creating /lp0 and not /dev/lp0.

Anuradha


----------------------------------
http://www.bee.lk/people/anuradha/

