Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269971AbRHEOlY>; Sun, 5 Aug 2001 10:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269967AbRHEOlO>; Sun, 5 Aug 2001 10:41:14 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:41229 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S269965AbRHEOlF>;
	Sun, 5 Aug 2001 10:41:05 -0400
Date: Sun, 5 Aug 2001 10:41:10 -0400 (EDT)
From: Robert Kuebel <kuebelr@email.uc.edu>
X-X-Sender: <kuebelr@oz.uc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: system freezes w/ 2.4.7-pre4 and later
In-Reply-To: <20010805102925.A278@cartman>
Message-ID: <Pine.OSF.4.33.0108051031490.27078-100000@oz.uc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i had the freeze in conjunction with
> 	- [2.4.7-pre4 .. 2.4.7] + xfs
> 	- iptables
> 	- pppoe
>
> now, i use:
> 	- 2.4.7, xfs
> 	- 2.4.7-ac6 patch
> 	  (only the netfilter part, cause the rest is not xfs clean ..)
> 	- iptables
> 	- pppoe
> and it works nice !

I have tried -ac6 with no luck.

> hmm .. may be you did some hot hdparm settings ?
>
> how about none hdparm settings ?

My hdparm setting are conservative:
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5606/255/63, sectors = 90069840, start = 0


