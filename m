Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbTCXXD7>; Mon, 24 Mar 2003 18:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbTCXXD7>; Mon, 24 Mar 2003 18:03:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:55458 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261165AbTCXXD6>;
	Mon, 24 Mar 2003 18:03:58 -0500
Date: Mon, 24 Mar 2003 17:19:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65: *huge* interactivity problems
Message-Id: <20030324171936.680f98e2.akpm@digeo.com>
In-Reply-To: <20030323231306.GA4704@elf.ucw.cz>
References: <20030323231306.GA4704@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 23:14:53.0317 (UTC) FILETIME=[2D257350:01C2F25B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> I'm having awfull interactivity problems. While lingvistic application
> (slm from nltools.sf.net) is running, machine is unusable. I still can
> read text in most, but can't login, can't run links, can't... For
> minutes.
> 
> slm does a lot of computation over ~250MB dataset, but during stall
> disk was not active.

Oh Pavel, this is more a whinge than a bug report.  You know better ;)

- How much memory does the machine have?

- UP/SMP/preempt?

- What do vmstat and top say?

- Did it happen in 2.5.64?  2.5.63?  2.4.20?

- Does it get better if you renice stuff?

- What steps should others take to reproduce it?

etc, etc, etc.

