Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280415AbRKNKgY>; Wed, 14 Nov 2001 05:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280419AbRKNKgP>; Wed, 14 Nov 2001 05:36:15 -0500
Received: from mustard.heime.net ([194.234.65.222]:38530 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280415AbRKNKgA>; Wed, 14 Nov 2001 05:36:00 -0500
Date: Wed, 14 Nov 2001 11:35:53 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: "Craig I. Hagan" <hagan@cih.com>
cc: <linux-kernel@vger.kernel.org>, <lars.nakkerud@compaq.com>
Subject: Re: Tuning Linux for high-speed disk subsystems
In-Reply-To: <Pine.LNX.4.33.0111130939030.1083-200000@svr.cih.com>
Message-ID: <Pine.LNX.4.30.0111141135140.5328-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this isn't quite true. use either the RH kernel, the -ac series, or the
> attached patch (for 2.4.15-pre4). Then set /proc/sys/vm/max-readahead to 511 or
> 1023 (power of 2 minus 1)
>
> this should allow you to generate large enough io's for streaming reads to do
> what you are looking for.

How does this work when using software RAID-0 or 5?
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

