Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290284AbSAXHYS>; Thu, 24 Jan 2002 02:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290285AbSAXHYI>; Thu, 24 Jan 2002 02:24:08 -0500
Received: from mx2.elte.hu ([157.181.151.9]:52380 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290284AbSAXHXw>;
	Thu, 24 Jan 2002 02:23:52 -0500
Date: Thu, 24 Jan 2002 10:21:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ingo's O(1) scheduler vs. wait_init_idle
In-Reply-To: <119440000.1011836623@flay>
Message-ID: <Pine.LNX.4.33.0201241020230.4694-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jan 2002, Martin J. Bligh wrote:

> I was trying to test this in my 8 way NUMA box, but this patch seems
> to have lost half of the wait_init_idle fix that I put in a while
> back. [...]

please check out the -J5 2.4.17/18 patch, thats the first 2.4 patch that
has the correct idle-thread fixes. (which 2.5.3-pre3 has as well.) Do you
still have booting problems?

	Ingo

