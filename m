Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbTBTW66>; Thu, 20 Feb 2003 17:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTBTW66>; Thu, 20 Feb 2003 17:58:58 -0500
Received: from tapu.f00f.org ([202.49.232.129]:47761 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267103AbTBTW65>;
	Thu, 20 Feb 2003 17:58:57 -0500
Date: Thu, 20 Feb 2003 15:09:03 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220230903.GA29018@f00f.org>
References: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com> <39710000.1045757490@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39710000.1045757490@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 08:11:31AM -0800, Martin J. Bligh wrote:

> There are patches in -mjb from Dave Hansen / Ben LaHaise to detect
> stack overflow included with the stuff for the 4K stacks patch
> (intended for scaling to large numbers of tasks). I've split them
> out attatched, should apply to mainline reasonably easily.

I tried with these patches and also wli's sched deadlock fix to see if
that helps.

Sadly not,  I can still easily reproduce a reboot.


  --cw
