Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263630AbTEOBt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTEOBt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:49:57 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:2806 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S263630AbTEOBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:49:57 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Davide Libenzi'" <davidel@xmailserver.org>,
       "'Andrew Morton'" <akpm@digeo.com>
Cc: "'Linus Torvalds'" <torvalds@transmeta.com>,
       <inaky.perez-gonzalez@intel.com>, <hch@infradead.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
Date: Wed, 14 May 2003 19:02:37 -0700
Organization: Murgatroid.Com
Message-ID: <002901c31a86$0f606020$175e040f@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.55.0305141841400.4539@bigblue.dev.mcafeelabs.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This should also break kernels with MMUs ( see mm_release ).

I don't believe it does as there's a cond_syscall entry for sys_futex.

More to the point, I'm running with CONFIG_FUTEX=n and it works fine.
I'm up to a whopping 304KiB MemFree with busybox and bluetooth
(hcid/sdpd/hciattach) running.

-ch
mailto:ch(at)hpl.hp.com
mailto:ch(at)murgatroid.com

