Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314609AbSD0Hxy>; Sat, 27 Apr 2002 03:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314610AbSD0Hxx>; Sat, 27 Apr 2002 03:53:53 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:32203 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S314609AbSD0Hxx>;
	Sat, 27 Apr 2002 03:53:53 -0400
Date: Sat, 27 Apr 2002 08:50:48 +0100
Message-Id: <200204270750.g3R7om023690@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Richard Thrapp <rthrapp@sbcglobal.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: The tainted message
In-Reply-To: <1019883102.8819.48.camel@wizard>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1019883102.8819.48.camel@wizard> you wrote:

> Secondly, loading the module doesn't actually 'taint' the kernel, but
> instead it mostly invalidates your chances for support from the core
> kernel maintainers.

and from most if not all distros

> I would like to propose that a clearer, more direct message be used. 
> Something like "Warning: kernel maintainers may not support your kernel
> since you have loaded %s: %s%s\n" would be much more informative and
> correct.

how about:
"Warning: loading non GPL kernel module. Your kernel will be
marked 'tainted'. This means kernel maintainers cannot support your kernel."

