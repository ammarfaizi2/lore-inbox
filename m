Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWIRWDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWIRWDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWIRWDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:03:33 -0400
Received: from tentacle.snto-msu.net ([194.88.210.4]:43962 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1030201AbWIRWDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:03:32 -0400
Date: Tue, 19 Sep 2006 02:03:31 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Andi Kleen <ak@suse.de>, Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918220331.GB32520@tentacle.sectorb.msk.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <200609181754.37623.ak@suse.de> <20060918162847.GA4863@ms2.inr.ac.ru> <200609181850.22851.ak@suse.de> <20060918211759.GB31746@tentacle.sectorb.msk.ru> <20060918220038.GB14322@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060918220038.GB14322@ms2.inr.ac.ru>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.17-rc6-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 02:00:38AM +0400, Alexey Kuznetsov wrote:
> Hello!
> 
> > Please think about it this way:
> > suppose you haave a heavily loaded router and some network problem is to
> > be diagnosed. You run tcpdump and suddenly router becomes overloaded (by
> > switching to timestamp-it-all mode
> 
> I am sorry. I cannot think that way. :-)
> 
> Instead of attempts to scare, better resend original report,
> where you said how much performance degraded, I cannot find it.
> 
> * I do see get_offset_pmtmr() in top lines of profile. That's scary enough.

I had it at the very top line.

> * I do not undestand what the hell dhcp needs timestamps for.
> * I do not listen any suggestions to screw up tcpdump with a sysctl.
>   Kernel already implements much better thing then a sysctl.
>   Do not want timestamps? Fix tcpdump, add an options, submit the
>   patch to tcpdump maintainers. Not a big deal. 

OK, point taken.
It's better to patch tcpdump.

> 
> Alexey
> 
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

