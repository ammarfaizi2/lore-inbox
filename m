Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSFKVlS>; Tue, 11 Jun 2002 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSFKVlQ>; Tue, 11 Jun 2002 17:41:16 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:40120 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316621AbSFKVlN>;
	Tue, 11 Jun 2002 17:41:13 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206112140.BAA14401@sex.inr.ac.ru>
Subject: Re: Multicast netlink for non-root process
To: jt@hpl.hp.com
Date: Wed, 12 Jun 2002 01:40:45 +0400 (MSD)
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020611141330.A22927@bougret.hpl.hp.com> from "Jean Tourrilhes" at Jun 11, 2 02:13:30 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	One potential reason is that some of the message may contain
> data that is root only. But this should be handled with a finer
> granularity.

Exactly. Taking into account that it is not handled with a finer granularity,
it is restricted in a facsict manner.

> netlink message to specify root only delivery (by the way of
> netlink_broadcast()). In all cases, the data producer is the one that
> knows what data is sensitive or not.

Some time ago, patch doing something sort of this was discussed
on netdev or here. Unfortunately, it was forgotten. So, we still have
the thing which we have.

Alexey
