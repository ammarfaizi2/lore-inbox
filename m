Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266450AbRGCGua>; Tue, 3 Jul 2001 02:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266449AbRGCGuU>; Tue, 3 Jul 2001 02:50:20 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:48891 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266448AbRGCGuO>; Tue, 3 Jul 2001 02:50:14 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107030649.f636nqB3001452@webber.adilger.int>
Subject: Re: [RFC][PATCH] struct kernel_stat -> struct cpu_stat[NR_CPUS]
In-Reply-To: <20010702163631.B9806@osdlab.org> "from Zach Brown at Jul 2, 2001
 04:36:31 pm"
To: Zach Brown <zab@osdlab.org>
Date: Tue, 3 Jul 2001 00:49:51 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack writes:
> These per cpu statistics are reported via a new /proc/cpustat, a quick
> tool for processing that output, vmstat-style, can be found near

Could you consider /proc/cpu/0/stats or similar?  It is much nicer
than polluting the top-level /proc directory, and I believe there
are a bunch of other per-cpu items waiting to go there as well
(process binding, hot-swap CPU stuff, etc)

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
