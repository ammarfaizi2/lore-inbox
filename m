Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSJWWi2>; Wed, 23 Oct 2002 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSJWWi2>; Wed, 23 Oct 2002 18:38:28 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:60833 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265247AbSJWWiX>; Wed, 23 Oct 2002 18:38:23 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 15:53:31 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
In-Reply-To: <Pine.LNX.4.44.0210231528580.1581-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0210231551230.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Davide Libenzi wrote:

> It'll take 2 minutes to do such a thing. Actually the pollfd struct
> contains the "events" field that is wasted when returning events and it
> could be used for something more useful.

Also, I was just wondering if this might be usefull :

asmlinkage int sys_epoll_wait(int epfd, int minevents, struct pollfd **events, int timeout);

Where "minevents" rapresent the minimum number of events returned by
sys_epoll ...



- Davide


