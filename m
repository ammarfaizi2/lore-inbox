Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVKZMdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVKZMdn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKZMdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:33:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28378 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750799AbVKZMdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:33:42 -0500
Date: Sat, 26 Nov 2005 13:33:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH -rt] export tsc_c3_compensate for x86_64
Message-ID: <20051126123331.GC3712@elte.hu>
References: <1132961284.24417.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132961284.24417.43.camel@localhost.localdomain>
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

> Ingo,
> 
> The tsc_c3_compensate needs to be exported for the x86_64 arch.

thanks, applied. (the GTOD/khrt trees should pick it up too)

	Ingo
