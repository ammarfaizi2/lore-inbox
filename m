Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVGVImI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVGVImI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVGVImI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:42:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:41445 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262051AbVGVImG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:42:06 -0400
To: <linux-kernel@vger.kernel.org>
Subject: =?iso-8859-1?Q?[COMPILE_ERROR]_realtime-preempt-2=2E6=2E12-final-V0=2E7=2E51-33_on_x86_64_SMP_system?=
From: =?iso-8859-1?Q?Steve_Wooding?= <steve_wooding@keysounds.co.uk>
Message-Id: <30280207$112202125842e0af8a66cf16.45394659@config22.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 30280207
X-Mailer: Webmail
X-Routing: UK
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Fri, 22 Jul 2005 10:40:01 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

I get the following compile error when using your patch
realtime-preempt-2.6.12-final-V0.7.51-33 on a x86_64 SMP system.

arch/x86_64/kernel/smpboot.c: 191: error: section of 'tsc_sync_lock'
conflicts with previous declaration.

It compiles fine if I don't set CONFIG_SMP=y, but then I can only use
one processor of my SMP system (not ideal).

Maybe you could find time to squash this bug.

Cheers,

Steve Wooding.
