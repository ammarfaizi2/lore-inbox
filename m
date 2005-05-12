Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVELIAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVELIAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVELIAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:00:08 -0400
Received: from imap.gmx.net ([213.165.64.20]:24497 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261298AbVELH7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 03:59:52 -0400
Date: Thu, 12 May 2005 09:59:50 +0200 (MEST)
From: "Manfred Schwarb" <manfred99@gmx.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
MIME-Version: 1.0
References: <20050511124640.GE8541@logos.cnet>
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
X-Priority: 3 (Normal)
X-Authenticated: #17170890
Message-ID: <8542.1115884790@www69.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The traces show huge networking execution paths.
> 
> It seems you are using some packet scheduler (CONFIG_NET_SCHED)? Pretty
> much all 
> traces show functions from sch_generic.c. Can you disable that for a test?
> 

Yes, indeed, I made some experiments with it, but do not need it urgently.
I will disable it, thanks for the hint.
And I will report back.

> > 
> > Below my three overflow messages. Would the stack reduction patches of
> Badari Pulavarty
> > help in my case? If so, I would strongly vote for inclusion into 2.4
> series!!
> 
> It has been decided that the stack reduction patches were too intrusive to
> be merged
> at this stage of v2.4 life. 
> 

OK, I got the message, I will consider upgrading to 2.6 sometime this
year...



-- 
+++ Lassen Sie Ihren Gedanken freien Lauf... z.B. per FreeSMS +++
GMX bietet bis zu 100 FreeSMS/Monat: http://www.gmx.net/de/go/mail
