Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266121AbSKUAVh>; Wed, 20 Nov 2002 19:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSKUAVg>; Wed, 20 Nov 2002 19:21:36 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:53124 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266121AbSKUAVe>; Wed, 20 Nov 2002 19:21:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 16:29:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 6 sys_poll/sys_select performance patches
In-Reply-To: <3DDC13F8.2030805@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0211201628471.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Manfred Spraul wrote:

> Attached are 6 patches that try to improve the performance of sys_poll
> and sys_select:
>
> - avoid dynamic memory allocations, stack storage is sufficient for most
> callers and faster.
> - use the wakeup callbacks and use that info to speed up the 2nd scan
> for new events.
>
> What do you think? Are there any apps/tests/benchmarks that stress
> sys_poll or sys_select?

You can try Ben's pipetest ...



- Davide


