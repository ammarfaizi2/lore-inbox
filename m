Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVKZMfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKZMfv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKZMfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:35:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14282 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932120AbVKZMfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:35:50 -0500
Date: Sat, 26 Nov 2005 13:35:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>,
       Aleksey Makarov <amakarov@dev.rtsoft.ru>
Subject: Re: [PATCH -rt] convert watchdog cpu5wdt from compat_sem to completion.
Message-ID: <20051126123547.GE3712@elte.hu>
References: <438709F5.1050801@dev.rtsoft.ru> <1132929218.11915.2.camel@localhost.localdomain> <1132959229.24417.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132959229.24417.35.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> OK Ingo,
> 
> This one is the last.  Of the compat_semaphores in drivers that I 
> looked at, these were the trivial ones.  The other ones I would not 
> touch unless I had hardware to test with, or the time to look deeper 
> into it.

thanks, applied.

	Ingo
