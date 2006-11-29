Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935412AbWK2H1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935412AbWK2H1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935416AbWK2H1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:27:11 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:48886 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S935412AbWK2H1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:27:10 -0500
Message-ID: <456D3676.5090706@web.de>
Date: Wed, 29 Nov 2006 08:27:50 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-rt9 - fails to compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.6.19-rc6-rt9 fails to compile on my Dual Core Notebook with FC6.

   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/time.h:7,
                  from include/linux/timex.h:57,
                  from include/linux/sched.h:50,
                  from include/linux/module.h:9,
                  from include/linux/crypto.h:21,
                  from arch/i386/kernel/asm-offsets.c:7:
include/linux/seqlock.h: In function '__read_seqretry':
include/linux/seqlock.h:139: error: expected expression before 'do'
In file included from include/linux/module.h:9,
                  from include/linux/crypto.h:21,
                  from arch/i386/kernel/asm-offsets.c:7:
include/linux/sched.h: In function 'dequeue_signal_lock':
include/linux/sched.h:1478: error: expected expression before 'do'
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

www.marcush.de/kernel/.config

Regards,
Marcus
