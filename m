Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbTCNXqP>; Fri, 14 Mar 2003 18:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbTCNXqP>; Fri, 14 Mar 2003 18:46:15 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:25747 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261282AbTCNXqP>; Fri, 14 Mar 2003 18:46:15 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Mar 2003 16:06:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jonathan Lemon <jlemon@flugsvamp.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030314173644.A77778@flugsvamp.com>
Message-ID: <Pine.LNX.4.50.0303141555560.1903-100000@blue1.dev.mcafeelabs.com>
References: <local.mail.linux-kernel/Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <local.mail.linux-kernel/20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel>
 <local.mail.linux-kernel/20030314155947.GD13106@netch.kiev.ua>
 <200303142143.h2ELheqx076668@mail.flugsvamp.com>
 <Pine.LNX.4.50.0303141412260.1903-100000@blue1.dev.mcafeelabs.com>
 <20030314162712.A77383@flugsvamp.com> <Pine.LNX.4.50.0303141444350.1903-100000@blue1.dev.mcafeelabs.com>
 <20030314173644.A77778@flugsvamp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Jonathan Lemon wrote:

> Yes, an API is a matter of personal taste, and I don't particularly like
> epoll, but that isn't really relevant.  What you seem to not understand
> is that kqueue is an event framework into which you plug different filters,
> which have different capabilities.  You may not like this "multiplexing",
> but that's part of the key to how kqueue works, and is THE reason it is not
> just "Yet Another Notification Mechanism".

I'm glad you seem to define kqueue "The Notification Mechanism", because
honestly, in my opinion "The Notification Mechanism" is what people
actually *uses* for real. Last time I checked "The Notification Mechanism"
is poll/select ( with kqueue pretty much down in the list ). Yes, maybe it
doesn't scale very well with high number of fds, but it does 99.99% of
what people needs. And the proof of this is that a huge number of
applications rely on poll/select. Why ? Beacause it's freakin' simple and
does the job. The new epoll interface aims to be that simple and to cover
the same needs that have driven developers to use select/poll. Who's right ?
Time will talk.




- Davide

