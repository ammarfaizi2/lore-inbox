Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJ0RTa>; Sat, 27 Oct 2001 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJ0RTU>; Sat, 27 Oct 2001 13:19:20 -0400
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:42383
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S273269AbRJ0RTG>; Sat, 27 Oct 2001 13:19:06 -0400
From: arjan@fenrus.demon.nl
To: mikpe@csd.uu.se (Mikael Pettersson)
Subject: Re: [PATCH] fix 2.4 SMP kernel hang on UP P4
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110271623.SAA04333@harpo.it.uu.se>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15xX6o-0002ct-00@fenrus.demon.nl>
Date: Sat, 27 Oct 2001 18:18:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110271623.SAA04333@harpo.it.uu.se> you wrote:
> Linus & Alan,

> A 2.4 kernel built with SMP or UP_APIC support may hang during boot
> if run on a UP P4 machine. The patch below fixes this, please apply.

can you also try a very recent -ac kernel (smp) and pass "acpismp=force" on
the lilo commandline ?
