Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312706AbSCVPQr>; Fri, 22 Mar 2002 10:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312705AbSCVPQg>; Fri, 22 Mar 2002 10:16:36 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:6395 "EHLO
	host140.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312706AbSCVPQY>; Fri, 22 Mar 2002 10:16:24 -0500
Date: Fri, 22 Mar 2002 15:15:21 +0000 (GMT)
From: Bernd Schmidt <bernds@redhat.com>
X-X-Sender: <bernds@host140.cambridge.redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: last write to drive issued with write cache off?
In-Reply-To: <200203221128.g2MBSnX13073@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0203221513430.21505-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Denis Vlasenko wrote:

> Re spindown: I don't see a reason why spindown via IDE 'sleep' command
> should sound differently from spindown due to poweroff.
> 
> So it is interesting to understand why Bernd's system started to emit
> 'funny noises'.
> 
> Maybe shutdown script does not realize that drives are spun down and cause 
> disk accesses which lead to spinup? That will be
> 
> normal -> spin down -> spin up -> poweroff and spindown
> 
> and indeed may sound funny :-)

I think the explanation may be that the drives are not spun down at the
same time, but with a one or two second delay, making it sound different
than usual.


Bernd

