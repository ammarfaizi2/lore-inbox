Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289357AbSBJIy3>; Sun, 10 Feb 2002 03:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289362AbSBJIyV>; Sun, 10 Feb 2002 03:54:21 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:28133 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S289357AbSBJIyO>;
	Sun, 10 Feb 2002 03:54:14 -0500
Message-Id: <m16ZpjT-000OVeC@amadeus.home.nl>
Date: Sun, 10 Feb 2002 08:53:11 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] BUG preserve registers
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3C661D89.8070202@zytor.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C661D89.8070202@zytor.com> you wrote:

> Of course, if the linker would fold strings for us then it would be a 
> helluva lot easier...

Recent combinations of gcc/binutils do this just fine.
The only question is: do we care for older toolchains (gcc <= 2.95) not
doing the optimal thing for 2.5.....
