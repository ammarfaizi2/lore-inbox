Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbSJ2BXm>; Mon, 28 Oct 2002 20:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSJ2BXm>; Mon, 28 Oct 2002 20:23:42 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:23965 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261396AbSJ2BXl>; Mon, 28 Oct 2002 20:23:41 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 17:39:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hanna Linder <hannal@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: and nicer too - Re: [PATCH] epoll more scalable
 than poll
In-Reply-To: <112700000.1035853724@w-hlinder>
Message-ID: <Pine.LNX.4.44.0210281734250.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Hanna Linder wrote:

> 	If you need any help with the Man pages I will be glad to
> help too. It looks like providing examples of how to use it would be
> very useful since this is something application writers are supposed
> to use...

IMHO I find the ephttpd.c, once stripped of the tons of #ifdef to handle
the other interfaces, to be a very clear example about how to use the API
togheter with coroutines. Using it with an event driven state machine
would require a little bit more code, but nothing brutal ...
Anyway yes, the NOTES section of the man pages should be "enriched" with a
few notes and maybe code samples.



- Davide


