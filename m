Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWHMQPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWHMQPa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHMQPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:15:30 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:31915 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751296AbWHMQP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:15:29 -0400
From: Matthias Dahl <mlkernel@mortal-soul.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: sluggish system responsiveness under higher IO load
Date: Sun, 13 Aug 2006 18:15:12 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608061200.37701.mlkernel@mortal-soul.de> <20060808190241.GB11829@suse.de> <20060810122853.GS11829@suse.de>
In-Reply-To: <20060810122853.GS11829@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608131815.12873.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 14:28, Jens Axboe wrote:

> > [...] It would be
> > nice if you could gather vmstat 1 info during a problematic period.
> > blktrace info could also be very useful:
>
> - Does disabling preemtion (CONFIG_PREEMPT_NONE=y) help?

First of all, I put the blktrace and vmstat logs on my webspace because they 
grew too big for the list to handle. :-)

  http://www.mortal-soul.de/blktrace.log.bz2
  http://www.mortal-soul.de/vmstat.log.bz2

Just let me know once you got them, so I can safely delete them again.

At the moment, I am trying without preemption but for example doing a untar 
kernel sources still results in sluggish system responsiveness. :-(

If I can do anything else, please let me know.
