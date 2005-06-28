Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVF1Qov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVF1Qov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVF1Qov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:44:51 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:28671 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261506AbVF1Qol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:44:41 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: oom-killings, but I'm not out of memory!
From: Alexander Nyberg <alexn@telia.com>
To: Anthony DiSante <theant@nodivisions.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42C179D5.3040603@nodivisions.com>
References: <42C179D5.3040603@nodivisions.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 18:44:33 +0200
Message-Id: <1119977073.1723.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running a 2.6.11 kernel.  I have 1 gig of RAM and 1 gig of swap.  Lately 
> when my RAM gets full, the oom-killer takes out either Mozilla or 
> Thunderbird (my two biggest memory hogs), even though my swap space is only 
> 20% full.  I still have ~800 MB of free swap space, so shouldn't the kernel 
> push Moz or T-bird into swap instead of oom-killing it?  At their maximum 
> memory-hogging capacity, neither Moz nor T-bird is ever using more than 200 MB.
>
> Jun 28 12:09:09 soma oom-killer: gfp_mask=0x80d2
> ...
> Jun 28 12:09:09 soma Free swap  = 781012kB
> Jun 28 12:09:09 soma Total swap = 987988kB
> Jun 28 12:09:09 soma Out of Memory: Killed process 30787 (thunderbird-bin).
> Jun 28 12:09:09 soma Out of Memory: Killed process 18112 (thunderbird-bin).
> Jun 28 12:09:09 soma Out of Memory: Killed process 18116 (thunderbird-bin).
> Jun 28 12:09:09 soma Out of Memory: Killed process 18117 (thunderbird-bin).
> Jun 28 12:09:09 soma Out of Memory: Killed process 18119 (thunderbird-bin).
> Jun 28 12:09:09 soma Out of Memory: Killed process 8857 (thunderbird-bin).
> 

You cut out the important part where it printed out memory usage
information at the time of the OOM, please post it

