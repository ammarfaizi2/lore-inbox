Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbRE3Uv2>; Wed, 30 May 2001 16:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbRE3UvS>; Wed, 30 May 2001 16:51:18 -0400
Received: from [158.152.228.152] ([158.152.228.152]:23942 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S262213AbRE3UvM>;
	Wed, 30 May 2001 16:51:12 -0400
Message-Id: <m155Csr-000OkJC@amadeus.home.nl>
Date: Wed, 30 May 2001 21:48:01 +0100 (BST)
From: arjan@fenrus.demon.nl
To: engler@csl.Stanford.EDU (Dawson Engler)
Subject: Re: [CHECKER] new floating point bugs in 2.4.5-ac4
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105302033.NAA07866@csl.Stanford.EDU>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200105302033.NAA07866@csl.Stanford.EDU> you wrote:
> Here are two new uses of floating point that popped up in the 2.4.5-ac4
> kernel.  While the expressions that use FP are trivial, at least my
> version of gcc does not calculate them at compile time.

> [BUG] DMFE_TX_KICK is (HZ * 0.5) which gcc does as floating point.  Fix is
>        trivial: just divide by 2 instead.

Fixed in 2.4.5-ac5 already
