Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312390AbSCUQvW>; Thu, 21 Mar 2002 11:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312389AbSCUQvN>; Thu, 21 Mar 2002 11:51:13 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:61445
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312388AbSCUQvH>; Thu, 21 Mar 2002 11:51:07 -0500
Date: Thu, 21 Mar 2002 08:50:24 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bernd Schmidt <bernds@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: last write to drive issued with write cache off?
In-Reply-To: <Pine.LNX.4.33.0203211601460.20748-100000@host140.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.10.10203210845450.4958-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Bernd Schmidt wrote:

> On Thu, 21 Mar 2002, Alan Cox wrote:
> 
> > > "To prevent loss of customer data, it is recommended that the last write access
> > > before power off be issued after setting the write cache off."
> > 
> > Standard 2.4 doesn't do this. 2.4.19-ac issues cache flushes.
> 
> Is this what's been causing my harddrives to make funny noises on shutdown
> recently?

Your so called funny noise is the process of flushing cache and putting
your drive to sleep in a spin down.  It only happens if you are going to
shutdown thw system.  If you are warm booting or rebooting you only get a
flush cache.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

