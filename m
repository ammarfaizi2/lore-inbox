Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVGMKse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVGMKse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGMKpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:45:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.190]:53755 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262612AbVGMKoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:44:03 -0400
To: <linux-kernel@vger.kernel.org>
Subject: =?iso-8859-1?Q?Real-Time_Preemption_Patch_-RT-2=2E6=2E12-final-V0=2E7=2E51-28_fails_to_compile_on_x86_64?=
From: =?iso-8859-1?Q?Steve_Wooding?= <steve_wooding@keysounds.co.uk>
Message-Id: <30280207$112125056942d4ed094ea249.34070914@config22.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 30280207
X-Mailer: Webmail
X-Routing: UK
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Wed, 13 Jul 2005 12:42:01 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've been trying to get the latest RT preempt patch to compile on the
x86_64 platform. Previous posts have helped me get passed the errors
I've encountered, but I've just come up against a new one. I'm using
the config that I have previously posted, except now I have
CONFIG_PREEMPT_RT set instead of CONFIG_PREEMPT_VOLUNTARY.

I now get the following error:

arch/x86_64/kernel/smpboot.c:191: error: section of 'tsc_sync_lock'
conflicts with previous declaration

I have patched the vanilla 2.6.12 kernel with
realtime-preempt-2.6.12-final-V0.7.51-28 patch file.

Let me know if any other info would help.

Cheers,

Steve Wooding.
