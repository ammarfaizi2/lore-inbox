Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266238AbRGGRPZ>; Sat, 7 Jul 2001 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbRGGRPP>; Sat, 7 Jul 2001 13:15:15 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:16597 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S266507AbRGGRPF>;
	Sat, 7 Jul 2001 13:15:05 -0400
Message-Id: <m15IvfY-000OzlC@amadeus.home.nl>
Date: Sat, 7 Jul 2001 18:15:00 +0100 (BST)
From: arjan@fenrus.demon.nl
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Subject: Re: RFC: Remove swap file support
cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B472C06.78A9530C@mandrakesoft.com> you wrote:
> Since you can make any file into a block device using loop,
> is there any value to supporting swap files in 2.5?

> swap files seem like a special case that is no longer necessary...

loop is always tricky re near-OOM deadlocks. It'll survive now, by sleeping
and waiting for memory, but swapping over that changes that equation.....
