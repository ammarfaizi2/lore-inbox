Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUIISl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUIISl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUIISh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:37:56 -0400
Received: from bos-gate1.raytheon.com ([199.46.198.230]:39882 "EHLO
	bos-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S266391AbUIISeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:34:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark_H_Johnson@raytheon.com, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Thu, 9 Sep 2004 13:31:10 -0500
Message-ID: <OFEEF7BCE0.67785078-ON86256F0A.0065BAEB-86256F0A.0065BB52@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/09/2004 01:31:22 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If you haven't done hdparm -u1 that may be a reason you want to touch
>these.

Alas, but
# hdparm /dev/hda
/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 64 (on)
 geometry     = 58168/16/63, sectors = 58633344, start = 0

so I already have IRQ's unmasked. [this was during no DMA tests, I usually
run with DMA enabled]

I'll be commenting on the results of the no DMA tests shortly.

  --Mark

