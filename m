Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJ1Wad>; Mon, 28 Oct 2002 17:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSJ1Wad>; Mon, 28 Oct 2002 17:30:33 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:23816 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S261627AbSJ1Wac>; Mon, 28 Oct 2002 17:30:32 -0500
Message-ID: <3DBDBBD6.3010602@ixiacom.com>
Date: Mon, 28 Oct 2002 14:36:06 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Dan Kegel <dkegel@ixiacom.com>
CC: linux-kernel@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] epoll more scalable than poll
References: <3DBDB33B.6000200@ixiacom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> The idea of using the kqueue interface was discussed once before.  See
> http://marc.theaimsgroup.com/?l=linux-kernel&m=97236943118139&w=2
> for Linus' opinion of kqueues (he doesn't like them much).

Hang on - reading again, I wonder if the main reason he didn't like
kqueue is because it allowed for multiple event queues
(so libraries don't need to be tightly integrated into
the main program, for instance).  He preferred one queue
and callbacks.

However, I think Linus admitted later on that nobody liked his
callback idea, so maybe he'd be receptive to the multiple
event queue idea now.

Um, I assume Ben's aio stuff allows multiple completion queues, right?
- Dan

