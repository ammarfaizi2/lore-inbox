Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276946AbRJCTEJ>; Wed, 3 Oct 2001 15:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276947AbRJCTD7>; Wed, 3 Oct 2001 15:03:59 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:62999 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S276946AbRJCTDq>; Wed, 3 Oct 2001 15:03:46 -0400
Date: Wed, 3 Oct 2001 15:03:55 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, hadi@cyberus.ca, linux-kernel@vger.kernel.org,
        Robert.Olsson@data.slu.se, netdev@oss.sgi.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011003150355.A3780@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110031702280.7221-100000@localhost.localdomain> <200110031653.UAA13938@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110031653.UAA13938@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Oct 03, 2001 at 08:53:58PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 08:53:58PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Citing my old explanation:
> 
> >"Polling" is not a real polling in fact, it just accepts irqs as
> >events waking rx softirq with blocking subsequent irqs.
> >Actual receive happens at softirq.
> >
> >Seems, this approach solves the worst half of livelock problem completely:
> >irqs are throttled and tuned to load automatically.
> >Well, and drivers become cleaner.

Well, this sounds like a 2.5 patch.  When do we get to merge it?

		-ben
