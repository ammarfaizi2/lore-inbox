Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTJVEfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 00:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTJVEfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 00:35:17 -0400
Received: from taco.zianet.com ([216.234.192.159]:59656 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S263406AbTJVEfL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 00:35:11 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Paul Jakma <paul@clubi.ie>
Subject: Re: Scaling noise
Date: Tue, 21 Oct 2003 21:46:41 -0600
User-Agent: KMail/1.5
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com> <200309272113.18030.elenstev@mesatop.com> <Pine.LNX.4.56.0310220220130.27492@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.56.0310220220130.27492@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310212146.41423.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 October 2003 07:22 pm, Paul Jakma wrote:
> On Sat, 27 Sep 2003, Steven Cole wrote:
> > It appears that SGI is working to scale the Altix to 128 CPUs on
> > Linux.
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106323064611280&w=2
>
> This may be interesting so:
>
> 	http://lwn.net/Articles/54822/
>
> it announces:
>
> 	"record levels of sustained performance and scalability on a
>         256-processor global shared-memory SGI Altix 3000 system, the
>         largest such system ever to run on the Linux ® operating
>         system."

This thread was continued with this post:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106471432320108&w=2

Quoting LM:
> Dave and friends can protest as much as they want that the kernel works
> and it scales (it does work, it doesn't scale by comparison to something
> like IRIX) 

Even though SGI is producing machines as noted above, and planning
on scaling to 512 or even 1024 processors in a SSI machine, that ability
to scale remains to be proven.  Meanwhile, IRIX is running a 2048 cpu
SSI machine at Wright-Patterson Air Force Base as noted here: 
http://www.sgi.com/newsroom/press_releases/2003/october/msrc.html

So, the original point seems to be holding for now.  It will be interesting
to see just how far the new (2.6) linux kernel will scale.

I've been having difficulty getting posts from home to reach lkml due to
a problem with my ISP inserting a bogus "Delivered-To" header, which
results in bounces from vger.kernel.org.  If this message reaches lkml, 
then my efforts to fix this have been successful.

Steven
