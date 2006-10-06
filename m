Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWJFP6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWJFP6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWJFP6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:58:30 -0400
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:16789 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751529AbWJFP63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:58:29 -0400
Date: Fri, 6 Oct 2006 17:58:33 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20061006175833.4ef08f06@localhost>
In-Reply-To: <200608131815.12873.mlkernel@mortal-soul.de>
References: <200608061200.37701.mlkernel@mortal-soul.de>
	<20060808190241.GB11829@suse.de>
	<20060810122853.GS11829@suse.de>
	<200608131815.12873.mlkernel@mortal-soul.de>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 18:15:12 +0200
Matthias Dahl <mlkernel@mortal-soul.de> wrote:

> Just let me know once you got them, so I can safely delete them again.
> 
> At the moment, I am trying without preemption but for example doing a untar 
> kernel sources still results in sluggish system responsiveness. :-(

I used to have this type of problem and 2.6.19-rc1 looks much better
than 2.6.18.

I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
and /proc/sys/vm/swappiness = 20.

-- 
	Paolo Ornati
	Linux 2.6.19-rc1 on x86_64
