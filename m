Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278566AbRKAIi7>; Thu, 1 Nov 2001 03:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278574AbRKAIit>; Thu, 1 Nov 2001 03:38:49 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:36529
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S278566AbRKAIi2>; Thu, 1 Nov 2001 03:38:28 -0500
From: arjan@fenrus.demon.nl
To: linux@mswinxp.net (Lee Packham)
Subject: Re: kbuild 2.5 preventing mixture of compilers
cc: linux-kernel@vger.kernel.org
In-Reply-To: <2644.192.168.2.1.1004602385.squirrel@mail.mswinxp.net>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15zDLz-0008Tf-00@fenrus.demon.nl>
Date: Thu, 01 Nov 2001 08:37:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <2644.192.168.2.1.1004602385.squirrel@mail.mswinxp.net> you wrote:
> IMHO, that is a good idea... almost.

> What about companies that maintain closed source driver modules for their 
> hardware?

> I know a lot of people here will say, 'well they should open source them 
> then'. However, some companies don't want to for their own reasons and 
> this 'could' blow them out the water a bit and affect end users.

If a different compiler version is known to break (and Keith says he has
seen that in practice, and I can see it happen as well given that a few
kernel headers depend on compiler version), the vendor in question is better
off being informed about the incompatibility. He _already_ has to have an
exact match on the kernel version and the other symbols, so adding the
compiler to that is not an extra burden, just a "oh we goofed" prevention..
