Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945954AbWGOWDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945954AbWGOWDb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 18:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945958AbWGOWDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 18:03:31 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:16000 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1945954AbWGOWDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 18:03:30 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Jul 2006 15:03:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Michael Lindner <mikell@optonline.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: epoll_wait() returns wrong events for EOF with EPOLLOUT
In-Reply-To: <200607141944.26010.mikell@optonline.net>
Message-ID: <Pine.LNX.4.64.0607151434470.4423@alien.or.mcafeemobile.com>
References: <200607141518.58635.mikell@optonline.net>
 <Pine.LNX.4.64.0607141535070.2463@alien.or.mcafeemobile.com>
 <200607141944.26010.mikell@optonline.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006, Michael Lindner wrote:

> On Fri July 14 2006 6:38 pm, Davide Libenzi wrote:
>> Please take a look at the POSIX docs for poll(2).
>
> My apologies - I had read very incomplete/misleading documentation - that'll
> learn me.
>
> So there's just "4. There has been no error on the FD, so why return
> EPOLLERR?"

Epoll returns the same conditions poll(2) (and file->f_ops->poll) returns.


- Davide


