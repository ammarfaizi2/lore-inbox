Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbTC2Lkh>; Sat, 29 Mar 2003 06:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbTC2Lkh>; Sat, 29 Mar 2003 06:40:37 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:16145 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S263405AbTC2Lkg>;
	Sat, 29 Mar 2003 06:40:36 -0500
Date: Sat, 29 Mar 2003 12:51:54 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel >2.5.63 broken (scheduler and VIA IDE)
Message-ID: <20030329115154.GA27368@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernels after 2.5.63 don't work well for me.
I get these IDE messages:

hda: dma_timer_expiry: dma status == 0x24
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

regularly (didn't happen with previous kernels) and the scheduler
appears to be unfair now.  As soon as I start one big CPU task (like
mencoder, oggenc or lame), the other tasks rarely if ever get to run at
all.

Felix
