Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264905AbSJ3UZ0>; Wed, 30 Oct 2002 15:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSJ3UZ0>; Wed, 30 Oct 2002 15:25:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13585 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264905AbSJ3UZY>; Wed, 30 Oct 2002 15:25:24 -0500
Date: Wed, 30 Oct 2002 12:31:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Janet Morgan <janetmor@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
In-Reply-To: <Pine.LNX.4.44.0210301228430.1446-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0210301230350.4060-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Oct 2002, Davide Libenzi wrote:
> 
> Thank you very much Janet for doing performance and stability test.
> Working with Andrew we agreed to remove the main hash table since, by
> using in full the fcblist.c capabilities, it is not needed any more.

Ok. I was just about to apply the 0.14 stuff, so please just cc me with 
the patch (and an appropriate description for the ChangeSet comment) when 
you're done with the cleanup..

		Linus

