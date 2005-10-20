Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVJTXeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVJTXeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVJTXeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:34:14 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:27144 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S932522AbVJTXeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:34:14 -0400
From: Felix Oxley <lkml@oxley.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc5-rt1
Date: Fri, 21 Oct 2005 00:33:48 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
In-Reply-To: <20051020195432.GA21903@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510210033.49652.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the following build error with make allyesconfig:

 CC      arch/i386/kernel/mca.o
arch/i386/kernel/mca.c: In function ‘mca_timer_ack’:
arch/i386/kernel/mca.c:488: error: ‘irq’ undeclared (first use in this function)
arch/i386/kernel/mca.c:488: error: (Each undeclared identifier is reported only once
arch/i386/kernel/mca.c:488: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/mca.o] Error 1
make: *** [arch/i386/kernel] Error 2


regards,
Felix
