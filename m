Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTEGTUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEGTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:19:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:28332 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264213AbTEGTRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:17:10 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 7 May 2003 12:31:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <Pine.LNX.4.53.0305071517100.13724@chaos>
Message-ID: <Pine.LNX.4.50.0305071225330.2208-100000@blue1.dev.mcafeelabs.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
 <Pine.LNX.4.53.0305071424290.13499@chaos>
 <Pine.LNX.4.50.0305071137330.2208-100000@blue1.dev.mcafeelabs.com>
 <Pine.LNX.4.53.0305071517100.13724@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Richard B. Johnson wrote:

> It is my understanding that there is one kernel stack. If there
> is a stack allocated for some "transition", and I guess there
> may be, because of the mail I'm getting, then it has absolutely
> no purpose whatsoever and is wasted valuable non-paged RAM.
>
> The reason why system-call parameters are passed in registers
> is so that we didn't have the overhead of copying stuff from a
> user stack to a kernel stack.
>
> Does anybody know (not guess) if this was stuff added for the
> new non-interrupt 0x80 syscall code? I want to know how a
> simple kernel got corrupted into this twisted thing.
>
> Anybody who has a copy of any of the Intel manuals since '386
> knows that there needs to be only one kernel stack.

I don't believe anyone is guessing here :)



- Davide

