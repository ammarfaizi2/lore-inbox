Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUIAOiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUIAOiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUIAOiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:38:10 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:57179 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S266777AbUIAOiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 10:38:07 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
From: Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Wed, 1 Sep 2004 09:37:39 -0500
Message-ID: <OFCD90FFE9.E98FB2D7-ON86256F02.00505992-86256F02.00505A16@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/01/2004 09:37:46 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok, the second try.

This patch appears to work well. No snd_es1371 traces in over 25 minutes
of testing (I had a couple hundred yesterday in similar tests). The sound
was OK as well.

I am seeing some additional CPU overhead during the disk I/O tests with
today's kernel but I don't think this is due to this patch.

Thanks.
  --Mark

