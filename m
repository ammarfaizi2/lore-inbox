Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265370AbSJRWDQ>; Fri, 18 Oct 2002 18:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265372AbSJRWCI>; Fri, 18 Oct 2002 18:02:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27141 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265369AbSJRWB5>; Fri, 18 Oct 2002 18:01:57 -0400
Date: Fri, 18 Oct 2002 15:05:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hanna Linder <hannal@us.ibm.com>
cc: bcrl@redhat.com, <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>,
       <davidel@xmailserver.org>
Subject: Re: [PATCH] sys_epoll system call interface to /dev/epoll
In-Reply-To: <44010000.1034978427@w-hlinder>
Message-ID: <Pine.LNX.4.44.0210181504470.11349-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, Hanna Linder wrote:
> 
> 	You said earlier that you didn't like epoll being
> in /dev. How about a system call interface instead? this
> patch provides the skeleton for that system call. We
> can have Davide's patch ported into it ASAP if you include 
> this by the freeze.

I like it noticeably better as a system call, so it's maybe worth 
discussing. It's not going to happen before I leave (very early tomorrow 
morning), but if people involved agree on this and clean patches to 
actiually add the code (not just system call stubs) can be made..

		Linus

