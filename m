Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTJBTIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTJBTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 15:08:04 -0400
Received: from 176.Red-81-38-200.pooles.rima-tde.net ([81.38.200.176]:1843
	"EHLO falafell") by vger.kernel.org with ESMTP id S263411AbTJBTIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 15:08:01 -0400
Date: Thu, 2 Oct 2003 21:07:44 +0200
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-ID: <20031002190744.GC1215@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au> <3F7863F0.6070401@wmich.edu> <20031002004102.GB2013@81.38.200.176> <3F7B9600.408@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7B9600.408@cyberone.com.au>
User-Agent: Mutt/1.5.4i
From: Pedro Larroy <piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 01:05:36PM +1000, Nick Piggin wrote:
> 
> 
> Pedro Larroy wrote:
> >Why not run xmms with SCHED_RR or SCHED_FIFO?
> >
> >
> 
> Well because playing an mp3 really is a pitiful task for modern CPUs,
> and the standard scheduler should handle this fine. Also a music skip
> isn't terribly important.
> 
> Realtime applications are difficult to make robust and they can easily
> hang the system.
> 

I think there are better aproaches for deciding when a task should be
interactive than the current one based in how much does the task sleep.

I'm afraid this selection criteria leads to a scheduler that isn't
predictable for situations that aren't the ones for which is tuned to work.
Of course I may be wrong, but to me, seems that saying explicitly 
which tasks are interactive sounds better.

-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
