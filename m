Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWFIKDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWFIKDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFIKDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:03:31 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:58240 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750995AbWFIKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:03:31 -0400
Date: Fri, 9 Jun 2006 12:01:23 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch, -rc6-mm1] irqflags tracing: fix x86_64 entry/exit
Message-ID: <20060609120123.55754169@localhost>
In-Reply-To: <20060609085920.GA4869@elte.hu>
References: <20060608213809.101161b0@localhost>
	<20060608215935.37c52bff@localhost>
	<20060609085920.GA4869@elte.hu>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006 10:59:20 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > void main(void)
> > {
> >         *(int*)(0) = 1;
> > }
> > 
> > and it will trigger.
> 
> thanks - please try the fix below - it has solved the problem on my 
> testbox.

Works here too.

:)

-- 
	Paolo Ornati
	Linux 2.6.17-rc6-mm1-lockdep on x86_64
