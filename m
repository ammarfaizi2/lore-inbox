Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSKBRzc>; Sat, 2 Nov 2002 12:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSKBRyN>; Sat, 2 Nov 2002 12:54:13 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:27011 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261361AbSKBRxu>; Sat, 2 Nov 2002 12:53:50 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 2 Nov 2002 10:05:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll ( aka full epoll support for poll() enabled
 devices ) ...
In-Reply-To: <20021102140653.GA3528@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0211021002530.1609-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, bert hubert wrote:

> On Fri, Nov 01, 2002 at 09:13:13PM -0800, Davide Libenzi wrote:
>
> > *) Multi-thread support. The wait interface is changed to :
> >
> > 	int epoll_wait(int epfd, struct pollfd *events, int maxevents,
> >                        int timeout);
>
> This means that userspace has to allocate I understand?

Yes, you have to allocate it in userspace.



> > *) Yes, ... it drops an event @ EP_CTL_ADD :)
>
> Thank you :-)

You're welcome, it came for free :)



> > The patch is working fine on my machine but it's very new code.
> > Comments and test reports will be very welcome ...
>
> I'll test. Do you want me to update the manpages to reflect the changes
> above?

Yes, I kind-of-updated the man pages ... but IMO 1) I need more test on it
2) there're still a few things open about the interface to be decided ...



- Davide


