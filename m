Return-Path: <linux-kernel-owner+w=401wt.eu-S964779AbWL0ROy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWL0ROy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933023AbWL0ROr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:14:47 -0500
Received: from quechua.inka.de ([193.197.184.2]:47682 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933017AbWL0ROb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:14:31 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <1167235772.3281.3977.camel@laptopd505.fenrus.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GzcMG-0001fV-00@calista.eckenfels.net>
Date: Wed, 27 Dec 2006 18:14:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1167235772.3281.3977.camel@laptopd505.fenrus.org> you wrote:
> once your program (and many others) have such a check, then the next
> step will be pressure on the kernel code to "fake" the old situation
> when there is a processor where <vague criteria of the day> no longer
> holds. It's basically a road to madness :-(

I agree that for HPC sizing a benchmark with various levels of parallelity
are better. The question is, if the code in question only is for inventory
reasons. In that case I would do something like x sockets, y cores and z cm
threads.

Bernd
