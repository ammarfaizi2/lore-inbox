Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVLGJcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVLGJcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVLGJcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:32:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750713AbVLGJcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:32:00 -0500
Date: Wed, 7 Dec 2005 01:31:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
       johnstul@us.ibm.com, mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-Id: <20051207013122.3f514718.akpm@osdl.org>
In-Reply-To: <1133908082.16302.93.camel@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0512061628050.1610@scrub.home>
	<1133908082.16302.93.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> We decided to rename 'ktimer' because Andrew pretty much vetoed the
>  'ktimeout' queue

Well I whined about the rename of timer_list to ktimeout and asked why it
happened.  I don't think anyone replied.

I assume from your above statement that there wasn't really a strong reason
for the rename, and that a new patch series is in the offing, which adds
ktimers and leaves timer_list alone?

Is ktimer a better name than ptimer or hrtimer?
