Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289352AbSAOBhz>; Mon, 14 Jan 2002 20:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289351AbSAOBhp>; Mon, 14 Jan 2002 20:37:45 -0500
Received: from tomts15.bellnexxia.net ([209.226.175.3]:1020 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S289344AbSAOBhf>; Mon, 14 Jan 2002 20:37:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
Date: Mon, 14 Jan 2002 20:37:30 -0500
X-Mailer: KMail [version 1.3.2]
Cc: mingo@elte.hu, <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
In-Reply-To: <Pine.LNX.4.40.0201131944290.933-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201131944290.933-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115013732.384A6BB346@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 10:45 pm, Davide Libenzi wrote:
> On Sun, 13 Jan 2002, Ed Tomlinson wrote:
> > With pre3+H7, kernel compiles still take 40% longer with a setiathome
> > process running at nice +19.  This is _not_ the case with the old
> > scheduler.
>
> Did you try to set MIN_TIMESLICE to 10 ( sched.h ) ?make bzImage with setiathome running nice +19

This makes things a worst - note the decreased cpu utilizaton...
  
make bzImage  424.33s user 32.21s system 48% cpu 15:48.69 total

What is this telling us?  

Ed Tomlinson

>>make bzImage  391.11s user 30.85s system 62% cpu 11:17.37 total
>>
>>make bzImage alone
>>
>>make bzImage  397.33s user 32.14s system 92% cpu 7:43.58 total
>>
>>Notice the large difference in run times...


