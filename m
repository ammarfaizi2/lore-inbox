Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbRELXnO>; Sat, 12 May 2001 19:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbRELXnE>; Sat, 12 May 2001 19:43:04 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:30164 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S261348AbRELXmr>;
	Sat, 12 May 2001 19:42:47 -0400
Date: Sun, 13 May 2001 01:42:45 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <20010512162501.A9471@one-eyed-alien.net>
Message-ID: <Pine.A41.4.31.0105130134030.19270-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2001, Matthew Dharm wrote:

> I was under the impression that you need to call swapon on swap partitions,
> and not on mounted filesystems.
hmm. so we can remove every check for good values in the kernel. yeah,
that would be pretty fast.
yes, I know it's really unusual to call sys_swapon with a mounted
partition, but IMHO sys_swapon is rarely called, so we can check if the
partition is mounted?

Bye,
Szabi


