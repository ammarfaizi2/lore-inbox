Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWARSvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWARSvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWARSvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:51:11 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:31201 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1030288AbWARSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:51:10 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 18 Jan 2006 10:51:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pepoll_wait ...
In-Reply-To: <43CE8B14.4020909@tls.msk.ru>
Message-ID: <Pine.LNX.4.63.0601181050200.6878@localhost.localdomain>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
 <43CE8B14.4020909@tls.msk.ru>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Michael Tokarev wrote:

> Davide Libenzi wrote:
>> 
>> The attached patch implements the pepoll_wait system call, that extend the 
>> event wait mechanism with the same logic ppoll and pselect do. The 
>> definition of pepoll_wait is:
>> 
>> int pepoll_wait(int epfd, struct epoll_event *events, int maxevents,
>>                 int timeout, const sigset_t *sigmask, size_t sigsetsize);
>
> How about epoll_pwait() instead?  It looks more appropriate, for
> my eyes anyway.  (Just a name, nothing more)

Thinking about it, it looks netter for me too. I'll change it if there are 
no other objections ...



- Davide


