Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268968AbRHBOpu>; Thu, 2 Aug 2001 10:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268951AbRHBOpk>; Thu, 2 Aug 2001 10:45:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268966AbRHBOpa>; Thu, 2 Aug 2001 10:45:30 -0400
Subject: Re: 3ware Escalade problems? Adaptec?
To: rothwell@holly-springs.nc.us
Date: Thu, 2 Aug 2001 15:47:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Michael Rothwell" at Aug 02, 2001 10:19:58 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJkk-0000ki-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been pricing out a 3ware-based raid system for my own personal use. Are
> the problems wuth the Escalade cards bad enough to consider not using them
> with 2.4.7?

Im really attached to my 3ware cards, they are the best ide raid cards I've
used. The newer boxes I built just use software raid 0/1 which is easy now
that everyone throws 4 UDMA100 channels on their motherboards.

I've also done the i2o driver fixups for the Promise SuperTrak100 with a
card provided by Promise and that works in -ac but not yet Linus tree.
I'm more impressed with the 3ware than the promise card right now, although
it will depend on workload. The promise card has onboard caches and raid5 
hardware which the earlier 3ware didn't.

