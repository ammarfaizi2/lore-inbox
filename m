Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319131AbSIDLEl>; Wed, 4 Sep 2002 07:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319135AbSIDLEl>; Wed, 4 Sep 2002 07:04:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47271 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319131AbSIDLEl>;
	Wed, 4 Sep 2002 07:04:41 -0400
Date: Wed, 4 Sep 2002 13:13:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Amos Waterland <apw@us.ibm.com>
Cc: pwaechtler@mac.com, <golbi@mat.uni.torun.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] POSIX message queues
In-Reply-To: <20020901015025.A10102@kvasir.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0209041311550.4000-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Sep 2002, Amos Waterland wrote:

> That is the fundamental problem with a userspace shared memory
> implementation: write permissions on a message queue should grant
> mq_send(), but write permissions on shared memory grant a lot more than
> just that.

is it really a problem? As long as the read and write queues are separated
per sender, all that can happen is that a sender is allowed to read his
own messages - that is not an exciting capability.

	Ingo

