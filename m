Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUGJM6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUGJM6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUGJM6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:58:30 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:50332 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266241AbUGJM62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:58:28 -0400
Message-ID: <2a4f155d04071005585b5d8999@mail.gmail.com>
Date: Sat, 10 Jul 2004 15:58:28 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040710123520.GA27278@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu> <2a4f155d040710035512f21d34@mail.gmail.com> <20040710123520.GA27278@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what filesystem are you using?
> 

XFS

> also, are you sure it's not pure IO latency (or swapout) that hits you?
> Do you get the same if you copy the music file to /dev/shm and play from
> there?

Ok tested with mplayer -ao jack it *didn't* skip once during a large
copy ( Tested with CFQ ). So I guess aRts has some problems with jack.

Cheers,
ismail

-- 
Time is what you make of it
