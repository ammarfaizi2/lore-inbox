Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVJPLJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJPLJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 07:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJPLJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 07:09:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751217AbVJPLJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 07:09:18 -0400
Date: Sun, 16 Oct 2005 13:09:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.14-rc4-rt6, depmod
Message-ID: <20051016110937.GA16016@elte.hu>
References: <1129442512.7978.3.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510160408540.2328@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510160408540.2328@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > WARNING: 
> > /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/char/hangcheck-timer.ko 
> > needs unknown symbol do_monotonic_clock
> 
> below is a patch to get this part to compile. (hopefully :-)

thanks, applied this and the i8253.c one too.

	Ingo
