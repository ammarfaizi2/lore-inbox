Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288059AbSATVml>; Sun, 20 Jan 2002 16:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSATVmb>; Sun, 20 Jan 2002 16:42:31 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:51364 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S288059AbSATVmQ>;
	Sun, 20 Jan 2002 16:42:16 -0500
Message-Id: <m16SPj2-000OVeC@amadeus.home.nl>
Date: Sun, 20 Jan 2002 21:42:04 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: ak@suse.de (Andi Kleen)
Subject: Re: performance of O_DIRECT on md/lvm
cc: linux-kernel@vger.kernel.org
In-Reply-To: <p734rlg90ga.fsf@oldwotan.suse.de>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <p734rlg90ga.fsf@oldwotan.suse.de> you wrote:

> I think an optional readahead mode for O_DIRECT would be useful. 

I disagree. O_DIRECT says "do not cache. period. I know what I'm doing"
and the kernel should respect that imho. After all we have sys_readahead for
the other part...
