Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUHJMmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUHJMmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHJMjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:39:53 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:1505 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264660AbUHJMiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:38:16 -0400
Subject: Re: pts/pty problem since 2.6.8-rc2
From: Soeren Sonnenburg <kernel@nn7.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1BuVgG-0000sc-2z@rhn.tartu-labor>
References: <E1BuVgG-0000sc-2z@rhn.tartu-labor>
Content-Type: text/plain
Message-Id: <1092141482.18080.42.camel@localhost>
Mime-Version: 1.0
Date: Tue, 10 Aug 2004 14:38:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 14:24, Meelis Roos wrote:
> SS> Whenever I boot a kernel of the 2.6.8-* series (also -rc3) I cannot open
> SS> up any xterms in X. I first have to lsof /dev/pts and kill all the 1-5
> SS> processes listed there. Afterwards xterm etc pops up without problems.
> 
> Might be relevant: I saw similar behaviour on a sparc64 at about
> 2.6.8-rc1 time - I could use only 2 pty's. That was with a kernel with
> PREEMPT turned on. The specific kernel gave BUGs and oopses because
> PREEMPT is not finished on sparc64 and I thought that the pty problem
> was caused by broken PREEMPT. I turned PREEMPT off and haven't seen the
> problem since then (running 2.6.8-rc4 currently).

actually I don't use a PREEMPT enabled kernel... but still see this
problem (but not with 2.6.7)...

I don't have a real idea what is causing this... anyway if I kill all
processes that were listed in lsof /dev/pts the problem seems gone... 
not sure whether this is some endianess thing (powerpc here)...

clueless,
Soeren

