Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVIHFhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVIHFhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVIHFhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:37:09 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43427 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932539AbVIHFhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:37:07 -0400
Message-ID: <431FCDBF.2010409@jp.fujitsu.com>
Date: Thu, 08 Sep 2005 14:35:59 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13 0/4] Cleanup - remove unnecessary handle_IRQ_event()
 prototype
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think the function prototypes for handle_IRQ_event() in
include/asm-{mips,ppc,sh,x86_64}/irq.h are no longer needed because
these architectures are using GENERIC_HARDIRQ. This series of patches
removes those unnecessary handle_IRQ_event() prototypes.

NOTE: Since I don't have these architectures, these patches are not
tested yet. I hope these patches will be tested by someone who has
these architectures.

Thanks,
Kenji Kaneshige
