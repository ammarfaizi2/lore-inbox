Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271600AbRHPRjP>; Thu, 16 Aug 2001 13:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271599AbRHPRjF>; Thu, 16 Aug 2001 13:39:05 -0400
Received: from femail13.sdc1.sfba.home.com ([24.0.95.140]:3521 "EHLO
	femail13.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271600AbRHPRiz>; Thu, 16 Aug 2001 13:38:55 -0400
Message-ID: <3B7C112F.1F2D183B@home.com>
Date: Thu, 16 Aug 2001 11:30:07 -0700
From: kernelkracker <isys1@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: global_irq_count vs global_irq_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is probably a kernel newbie question so my apologies in advance.

I have a design/implementation question.

global_irq_count is defined as atomic_t whereas globall_irq_lock is
defined as unsigned volatiile int.
Is this by design? or by chance?

Why would you be concerned about reading global_irq_count atomically and
not global_irq_count as it is done is several
functions in linux/arch/i386/irq.c in kernel 2.2.18.

If it is by design, what am I missing.

Please cc me on your respone as I am not on the list.

Take care!

