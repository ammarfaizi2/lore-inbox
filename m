Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264453AbUESRVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUESRVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUESRVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:21:04 -0400
Received: from vogsphere.datenknoten.de ([212.12.48.49]:52642 "EHLO
	vogsphere.datenknoten.de") by vger.kernel.org with ESMTP
	id S264453AbUESRVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:21:01 -0400
Subject: Re: Strange DMA-errors and system hang with Promise 20268
From: Sebastian <sebastian@expires0604.datenknoten.de>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c2dsha$psd$1@sea.gmane.org>
References: <1078602426.16591.8.camel@vega>  <c2dsha$psd$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1084987258.4662.4.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 19:20:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 07.03.2004 schrieb Mario 'BitKoenig' Holbe um 2:05:
> Mar  6 01:10:22 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> 
> Can you somehow correlate this to start of S.M.A.R.T selftests?
> 
> I suspect it having something to do with 2.4.25 new "One last
> read after the timeout" in ide-iops.c and accessing the drive
> while selftest running (possibly especially short selftest).
> Here, daily at 01:00 smartmontools runs smart short selftests
> and a bit later the machine hangs.
> Today, I disabled that job and the machine stays stable.

Same thing here. The machine crashes on weekends shortly after 01:00
after I had upgraded to 2.4.25 and 2.4.26. I disabled smart as you
suggested, but too recently to be sure that it was the cause. It could
just be related to additional load caused by cron jobs?

Any confirmed solutions yet?

Sebastian

