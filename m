Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUEWVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUEWVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUEWVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:03:16 -0400
Received: from ktown.kde.org ([131.246.103.200]:22467 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S262996AbUEWVDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:03:15 -0400
Date: Sun, 23 May 2004 23:03:13 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040523210313.GA16310@ugly.local>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405240254.20171.kernel@kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 02:54:19AM +1000, Con Kolivas wrote:
> Your example of poor performance is one when the cpu performance is
> marginal to get exactly 30 fps processed and on the screen. The cpu
> overhead in 2.6 is slightly higher than 2.4 so a borderline case may
> be just pushed over. 
> 
"his" example is in fact mine. 2.4 ghz chew 25 fps. the total cpu load
is at 30-40% (depending on the selected deinterlacer algorithm).

> A program running as sched_fifo it will preempt absolutely everything 
> regardless of how it behaves.
>
errm ... right. i paid too little attention to this "tiny" detail.
*blush*

now i hacked tvtime to simply ignore v4l2 ... and guess what? it works
...
so the new theory is, that tvtime has some problem with v4l2 input
buffering ...

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
