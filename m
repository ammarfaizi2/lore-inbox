Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310649AbSCHC1V>; Thu, 7 Mar 2002 21:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310650AbSCHC1M>; Thu, 7 Mar 2002 21:27:12 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26363
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310649AbSCHC05>; Thu, 7 Mar 2002 21:26:57 -0500
Date: Thu, 7 Mar 2002 18:27:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
Message-ID: <20020308022751.GF28141@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020308000504.GE28141@matchmail.com> <E16j8P5-0004NW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16j8P5-0004NW-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 12:38:35AM +0000, Alan Cox wrote:
> > I'm running kde, mutt, mozilla, make -j5 kernel compile on a loop for the
> > last coupld days.  I wasn't using this much address space with the same work
> > load yesterday, so that's why I think there is a bug there.  
> 
> Could be  - or an app decided to spring a leak. You might want to see if
> a lot of it vanishes when you kill specific things
> 

True.

Won't this show up in rss or some other ps mem listing -or- is this
something that hasn't been exported to user space before on linux?
