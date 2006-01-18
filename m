Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWARShy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWARShy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWARShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:37:54 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:54366 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1030257AbWARShx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:37:53 -0500
Message-ID: <43CE8B14.4020909@tls.msk.ru>
Date: Wed, 18 Jan 2006 21:38:12 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pepoll_wait ...
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> The attached patch implements the pepoll_wait system call, that extend 
> the event wait mechanism with the same logic ppoll and pselect do. The 
> definition of pepoll_wait is:
> 
> int pepoll_wait(int epfd, struct epoll_event *events, int maxevents,
>                 int timeout, const sigset_t *sigmask, size_t sigsetsize);

How about epoll_pwait() instead?  It looks more appropriate, for
my eyes anyway.  (Just a name, nothing more)

/mjt
