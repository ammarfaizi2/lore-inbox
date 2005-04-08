Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVDHToA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVDHToA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVDHToA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:44:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39942 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262937AbVDHTn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:43:57 -0400
Date: Fri, 8 Apr 2005 21:43:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Yum Rayan <yum.rayan@gmail.com>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-ID: <20050408194355.GH15688@stusta.de>
References: <4252BC37.8030306@grupopie.com> <20050407214747.GD4325@stusta.de> <42567B3E.8010403@grupopie.com> <20050408130008.GA6653@stusta.de> <4256B04A.8070909@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4256B04A.8070909@grupopie.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 05:24:42PM +0100, Paulo Marques wrote:
> Adrian Bunk wrote:
> >[...]
> >>>On Tue, Apr 05, 2005 at 05:26:31PM +0100, Paulo Marques wrote:
> >>
> >>Hi Adrian,
> >
> >Hi Paolo,
> 
> Paulo, please :)
>...

The second name I got wrong today...

Sorry.

>...
> >Joerg's list of recursions should be valid independent of the kernel 
> >version. Fixing any real stack problems [1] that might be in this list 
> >is a valuable task.
> >
> >And "make checkstack" in a kernel compiled with unit-at-a-time lists 
> >several possible problems at the top.
> 
> Ok, I've read Jörn's mail also and I think I can help out. It seems 
> however that there are more people working on this. Will it be better to 
> coordinate so we don't duplicate efforts or is the "everyone looks at 
> everything" approach better, so that its harder to miss something?

The only other person that seemed very interested n stack issues was
Yum Rayan <yum.rayan@gmail.com>.

You could coordinate with him, but in the end it should be possible to 
have a first set of patches ready a few hours or even minutes after you 
started, so duplicate efforts would require a very unlucky timing.

> Paulo Marques

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

