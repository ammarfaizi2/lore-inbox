Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277065AbRJDBaO>; Wed, 3 Oct 2001 21:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277066AbRJDB3y>; Wed, 3 Oct 2001 21:29:54 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:1457 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277065AbRJDB3w>; Wed, 3 Oct 2001 21:29:52 -0400
Date: Wed, 3 Oct 2001 21:30:11 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: jamal <hadi@cyberus.ca>
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org,
        Robert.Olsson@data.slu.se, netdev@oss.sgi.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011003213010.F3780@redhat.com>
In-Reply-To: <20011003150355.A3780@redhat.com> <Pine.GSO.4.30.0110032105150.8016-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0110032105150.8016-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Wed, Oct 03, 2001 at 09:10:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 09:10:10PM -0400, jamal wrote:
> > Well, this sounds like a 2.5 patch.  When do we get to merge it?
> 
> 
> It is backward compatible to 2.4 netif_rx() which means it can go in now.
> The problem is netdrivers that want to use the interface have to be
> morphed.

I'm alluding to the fact that we need a place to put in-development patches.

> As a general disclaimer, i really dont mean to put down Ingo's efforts i
> just think the irq mitigation idea as is now is wrong for both 2.4 and 2.5

What is your solution to the problem?  Leaving it up to the driver authors 
doesn't work as they're not perfect.  Yes, drivers should attempt to do a 
good job at irq mitigation, but sometimes a safety net is needed.

		-ben
