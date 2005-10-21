Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVJUK05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVJUK05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVJUK05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 06:26:57 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:61200 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932561AbVJUK04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 06:26:56 -0400
From: Felix Oxley <lkml@oxley.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc5-rt1
Date: Fri, 21 Oct 2005 11:26:36 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20051017160536.GA2107@elte.hu> <200510211101.18391.lkml@oxley.org> <200510211118.18363.lkml@oxley.org>
In-Reply-To: <200510211118.18363.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510211126.38200.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 October 2005 11:18, Felix Oxley wrote:

> So since I am only build testing I will comment it out.
> 

Thta did not advance me very far!

  CC      kernel/time/clockevents.o
kernel/time/clockevents.c: In function ‘clockevents_set_next_event’:
kernel/time/clockevents.c:519: error: request for member ‘tv_sec’ in something not a structure or union
kernel/time/clockevents.c:519: error: request for member ‘tv_nsec’ in something not a structure or union
make[2]: *** [kernel/time/clockevents.o] Error 1
make[1]: *** [kernel/time] Error 2
make: *** [kernel] Error 2

Another ktimer_trace with incorrect arguments AFAICT.

I will try again with -rc5-rt3. :-)

regards,
Felix
