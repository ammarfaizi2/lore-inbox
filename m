Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310324AbSCBGCv>; Sat, 2 Mar 2002 01:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310326AbSCBGCm>; Sat, 2 Mar 2002 01:02:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:7067 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310324AbSCBGC1>; Sat, 2 Mar 2002 01:02:27 -0500
Date: Fri, 1 Mar 2002 23:16:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301231639.A14413@vger.timpanogas.org>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <20020301165104.C6778@beaverton.ibm.com> <20020301213908.B13983@vger.timpanogas.org> <20020301225918.A14239@vger.timpanogas.org> <20020301230142.B14239@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020301230142.B14239@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Mar 01, 2002 at 11:01:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 11:01:42PM -0700, Jeff V. Merkey wrote:
> On Fri, Mar 01, 2002 at 10:59:18PM -0700, Jeff V. Merkey wrote:
> > 
> > 
> > Mike,
> > 
> > Here are some numbers from the running system.  This system is 
> > running at 120 MB/S 

Mike,

Also, I've had a single adapter above 150 MB/S.  This test I am running
was to test this 15 queue depth issue, so I took the system down 
to a single adapter for the test so I could get the stats you raised the 
issue about.

Jeff


on a single 3Ware adapter.  Stats attached.  You
> > will note that the max commands hitting the adapter are way above
> > 15.  I can only presume this is due to caching behavior on the card.
> > I do have these cards enabled with caching.  I have had these numbers
> > as high as 319 MB/S with multiple cards in separate buses.  The system
> > this test is running on has 3 PCI buses.  2 x 33 Mhz and 1 x 66 Mhz.  
> > with Serverwork HE Chipset.
> > 
