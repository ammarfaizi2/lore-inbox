Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbRLIJsX>; Sun, 9 Dec 2001 04:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283272AbRLIJsN>; Sun, 9 Dec 2001 04:48:13 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:17025 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S283268AbRLIJrx>;
	Sun, 9 Dec 2001 04:47:53 -0500
Message-Id: <m16D0Yk-000OXEC@amadeus.home.nl>
Date: Sun, 9 Dec 2001 09:47:46 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: rusty@rustcorp.com.au (Rusty Russell)
Subject: Re: Linux 2.4.17-pre5
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011208214631.75573e9a.rusty@rustcorp.com.au>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011208214631.75573e9a.rusty@rustcorp.com.au> you wrote:
> On Fri, 7 Dec 2001 00:09:12 +0000 (GMT)
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> > > Actually that one is  various Intel people not me 8)
>> > 
>> > Wouldn't it be better to see such things proven right in 2.5 first ?
>> 
>> o     2.5 isnt going to be usable for that kind of thing in the near future
>> o     There is no code that is "new" for normal paths (in fact Marcelo
>>       wanted a change for the only "definitely harmless" one there was)

> The sched.c change is also useless (ie. only harmful).

The intention seems to be to avoid the situation where one "pair" is
executing 2 processes while other "pair"s are fully idle. It makes a
difference for the "system is < 50% busy" case, NOT for the "system is very
busy" case....

