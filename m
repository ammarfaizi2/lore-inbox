Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSBDMMy>; Mon, 4 Feb 2002 07:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSBDMMp>; Mon, 4 Feb 2002 07:12:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18388 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288936AbSBDMMj>;
	Mon, 4 Feb 2002 07:12:39 -0500
Date: Mon, 4 Feb 2002 15:09:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5E66DB.6B1B2BDC@redhat.com>
Message-ID: <Pine.LNX.4.33.0202041509001.6542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Arjan van de Ven wrote:

> > yes - but what makes them an application is not really the fact that they
> > share the VM (i can very much imagine thread-based login servers where
> > different users use different threads - a single application as well?),
> > but the intention of the application designer, which is hard to guess.
>
> sharing the same Thread Group ID would be a very obvious quantity to
> check, and would very much show the indication of the application
> author.

agreed.

	Ingo

