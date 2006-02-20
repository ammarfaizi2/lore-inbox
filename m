Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWBTKGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWBTKGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBTKGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:06:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50836 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964827AbWBTKGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:06:44 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Hensler <matthias@wspse.de>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
In-Reply-To: <20060220093911.GB19293@kobayashi-maru.wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz>
	 <200602110116.57639.sebas@kde.org>
	 <20060211104130.GA28282@kobayashi-maru.wspse.de>
	 <20060218142610.GT3490@openzaurus.ucw.cz>
	 <20060220093911.GB19293@kobayashi-maru.wspse.de>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 05:06:42 -0500
Message-Id: <1140430002.3429.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> These "big changes" is something I have a problem with, since it means
> to delay a working suspend/resume in Linux for another
> "short-term" (so
> what does it mean: 1 month? six? twelve?). It is painful to get these
> things to work reliable, I have followed this for nearly 1.5 years.
> And
> again: today there is a working implementation, so why not merge it
> and
> have something today, and then start working on the other things. 

It never works that way in practice - if you let broken/suboptimal code
into the kernel then it's a LOT less likely to get fixed later than if
you make fixing it a condition of inclusion because once it's in there's
much less motivation to fix it.

Lee



