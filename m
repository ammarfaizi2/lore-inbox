Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTIJFfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbTIJFfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:35:32 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6929
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264549AbTIJFfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:35:31 -0400
Date: Tue, 9 Sep 2003 22:35:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       John Yau <jyau_kernel_dev@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Priority Inversion in Scheduling
Message-ID: <20030910053549.GE28279@matchmail.com>
Mail-Followup-To: Mike Galbraith <efault@gmx.de>,
	Nick Piggin <piggin@cyberone.com.au>,
	John Yau <jyau_kernel_dev@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com> <3F5E6F15.6040507@cyberone.com.au> <6.0.0.22.0.20030910062610.01cfacd8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.0.0.22.0.20030910062610.01cfacd8@pop.gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:42:10AM +0200, Mike Galbraith wrote:
> At 02:23 AM 9/10/2003, Nick Piggin wrote:
> >Hi John,
> >Your mechanism is basically "backboost". Its how you get X to keep a
> >high piroirity, but quite unpredictable. Giving a boost to a process
> >holding a semaphore is an interesting idea, but it doesn't address the
> >X problem.
> 
> FWIW, I tried the hardware usage bonus thing, and it does cure the X 
> inversion problem (yeah,  it's a pretty cheezy way to do it).  It also 
> cures xmms skips if you can't get to the top without hw usage.  I also 
> tried a cpu limited backboost from/to tasks associated with hardware, and 
> it hasn't run amok... yet ;-)

Against which scheduler, and when are you going to post the patch?
