Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTBOVm5>; Sat, 15 Feb 2003 16:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBOVm5>; Sat, 15 Feb 2003 16:42:57 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:33166 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265198AbTBOVm4>; Sat, 15 Feb 2003 16:42:56 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Feb 2003 14:00:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Werner Almesberger <wa@almesberger.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030215010837.D2791@almesberger.net>
Message-ID: <Pine.LNX.4.50.0302151359020.1891-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
 <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com>
 <20030215010837.D2791@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Werner Almesberger wrote:

> Davide Libenzi wrote:
> > What do you think about having timers through a file interface ?
>
> Maybe I'm missing something obvious, but couldn't you simply
> do this with a signal handler that writes to (a) pipe(s) ?

You could do that, even if when you start having many timers things might
get messy.



- Davide

