Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282424AbRKZTPM>; Mon, 26 Nov 2001 14:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282040AbRKZTN1>; Mon, 26 Nov 2001 14:13:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9953 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282263AbRKZTM7>;
	Mon, 26 Nov 2001 14:12:59 -0500
Date: Mon, 26 Nov 2001 22:10:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0111262209220.18923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Ingo Molnar wrote:

> [...] And it should not be a problem that this is not race-free -
> missing to set the referenced bit is not a big failure.

(in the swapping code this race might be more lethal - so this
optimization would only be for the pagecache lookup only.)

	Ingo

