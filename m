Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132309AbRBRNGG>; Sun, 18 Feb 2001 08:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRBRNF4>; Sun, 18 Feb 2001 08:05:56 -0500
Received: from chiara.elte.hu ([157.181.150.200]:4612 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132309AbRBRNFp>;
	Sun, 18 Feb 2001 08:05:45 -0500
Date: Sun, 18 Feb 2001 14:04:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mordechai Ovits <movits@ovits.net>
Cc: Andre Tomt <andre@tomt.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 crashing every other day
In-Reply-To: <20010218003125.A25564@ovits.net>
Message-ID: <Pine.LNX.4.30.0102181404020.2972-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Feb 2001, Mordechai Ovits wrote:

> Looks like you were bitten by either the RAID 1 bugs or the elevator
> bugs. Try a 2.4.2-pre4 or an 2.4.1-ac18 kernel.  Should solve it.

the crash does not look like to be even in the neighborhood of RAID1 or
elevator (it crashed in __page_alloc() made by fork) - but a -ac18 test is
recommended nevertheless, there were a couple of other bugs fixed too.

	Ingo

