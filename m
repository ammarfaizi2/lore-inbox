Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293394AbSCARK3>; Fri, 1 Mar 2002 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293408AbSCARKK>; Fri, 1 Mar 2002 12:10:10 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:44038 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293394AbSCARKC>; Fri, 1 Mar 2002 12:10:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 1 Mar 2002 09:13:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Sean Hunter <sean@dev.sportingbet.com>
cc: Rik van Riel <riel@conectiva.com.br>, Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <20020301103600.D7765@dev.sportingbet.com>
Message-ID: <Pine.LNX.4.44.0203010911070.1531-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Sean Hunter wrote:

> Excuse my stupidity, but would a patch that just adds Davide's macro and
> changes all instances of
>
> current->policy |= SCHED_YIELD;
> schedule();
>
> to yield() be acceptable?  Is there more involved than that, because I am
> perfectly happy to create and submit such a patch.
>
> ...or am I just being dumb?

The purpose of the macro would be to create a compatibility layer to
1) cleanup 2.4.x code 2) facilitate o(1) sched integration



- Davide


