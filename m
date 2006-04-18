Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWDROQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWDROQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDROQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:16:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48516 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932146AbWDROQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:16:26 -0400
Date: Tue, 18 Apr 2006 15:12:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt] Remove false BUG_ON from rtmutex.c
Message-ID: <20060418131233.GA6825@elte.hu>
References: <1145324887.17085.35.camel@localhost.localdomain> <1145369590.17085.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145369590.17085.99.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Here's a patch to remove the BUG_ON in rtmutex.c.  I previously showed 
> that the condition in that particular BUG_ON can legitimately be the 
> case.

thanks, applied.

	Ingo
