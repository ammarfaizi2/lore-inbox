Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288266AbSANDkB>; Sun, 13 Jan 2002 22:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSANDjv>; Sun, 13 Jan 2002 22:39:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:62736 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288266AbSANDjo>; Sun, 13 Jan 2002 22:39:44 -0500
Date: Sun, 13 Jan 2002 19:45:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ed Tomlinson <tomlins@cam.org>
cc: mingo@elte.hu, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
In-Reply-To: <20020114032702.8EA14CA7EA@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.40.0201131944290.933-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Ed Tomlinson wrote:

> With pre3+H7, kernel compiles still take 40% longer with a setiathome
> process running at nice +19.  This is _not_ the case with the old scheduler.

Did you try to set MIN_TIMESLICE to 10 ( sched.h ) ?




- Davide


