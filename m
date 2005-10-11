Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVJKKyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVJKKyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 06:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJKKyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 06:54:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:5060 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751339AbVJKKys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 06:54:48 -0400
Date: Tue, 11 Oct 2005 12:55:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Rigg <lk@sound-man.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
Message-ID: <20051011105509.GA15091@elte.hu>
References: <E1ENxei-0001C9-F7@localhost.localdomain> <Pine.LNX.4.58.0510071538380.8980@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510071538380.8980@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > I wonder if DEBUG_STACKOVERFLOW was left out of x86_64 for this reason.
> 
> Here's an addon patch to my last one.  I don't know x86_64 very well, 
> but I believe the the asm is pretty much the same, so this patch 
> removes the check for __i386__ and also defines STACK_WARN.

this wont work on x64 - but i've now implemented this in my tree and it 
should work fine in -rc4-rt1.

	Ingo
