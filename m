Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUA1W7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUA1W7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:59:25 -0500
Received: from mail.broadpark.no ([217.13.4.2]:31198 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265965AbUA1W7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:59:21 -0500
Date: Wed, 28 Jan 2004 23:59:10 +0100
From: Daniel Andersen <kernel-list@majorstua.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1:Badness in try_to_wake_up at kernel/sched.c:722
Message-Id: <20040128235910.3f2a57c3.kernel-list@majorstua.net>
In-Reply-To: <1075319562.796.0.camel@teapot.felipe-alfaro.com>
References: <1075312502.2090.28.camel@arrakis>
	<1075319562.796.0.camel@teapot.felipe-alfaro.com>
Reply-To: daniel@majorstua.net
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2004-01-28 at 18:55, Adam Koszela wrote:
> > So here's my problem:
> > Performance, especially when switching/launching/killing apps is awful,
> > and dmesg spits out:
> > 
> > Badness in try_to_wake_up at kernel/sched.c:722
> > Call Trace:
> >  [<c011aac5>] try_to_wake_up+0x91/0x1c9
> 
> C'mon people, this has been reported at least four times ;-)
> I'm sure Andrew is looking into it right now.

I get the same message myself when using xmms.

AFAICS this is not much to worry about. It is only a new debug message which did not exist in 2.6.2-rc2 or earlier.

Daniel Andersen
