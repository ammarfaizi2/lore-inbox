Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVK2PsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVK2PsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVK2PsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:48:17 -0500
Received: from xenotime.net ([66.160.160.81]:62902 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751384AbVK2PsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:48:16 -0500
Date: Tue, 29 Nov 2005 07:48:38 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Mike Krufky <mkrufky@linuxtv.org>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: saa7134 broken in 2.6.15-rc2
Message-Id: <20051129074838.5a2d3675.rdunlap@xenotime.net>
In-Reply-To: <438B287D.9030607@linuxtv.org>
References: <20051128135254.GA4218@wonderland.linux.it>
	<20051128141003.GA4806@wonderland.linux.it>
	<438B1F89.7000402@linuxtv.org>
	<200511281035.18541.gene.heskett@verizon.net>
	<438B287D.9030607@linuxtv.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2005 10:55:41 -0500 Mike Krufky wrote:

> Gene Heskett wrote:
> 
> >On Monday 28 November 2005 10:17, Mike Krufky wrote:
> >  
> >
> >>Marco d'Itri wrote:
> >>    
> >>
> >>>On Nov 28, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
> >>>      
> >>>
> >>>>here seems to be something rotten in v4l land; here's one I got with
> >>>>2.6.15-rc1-git1
> >>>>        
> >>>>
> >>>Yes, I should have STFW better:
> >>>http://lkml.org/lkml/fancy/2005/11/24/194 .
> >>>
> >>>video-buf is still broken for me in -rc2, I can make xawtv work if I
> >>>set capture to "overlay", but it still complain about no input
> >>>sources other than "default".
> >>>      
> >>>
> >>Please try again, using the current -git snapshot.... The memory
> >>problems have been fixed by Hugh Dickins in 2.6.15-rc2-git3 , and
> >>Dmitry has submitted some input fixes after that.....
> >>
> >>I am running 2.6.15-rc2-git6 with no problems.
> >>
> >>    
> >>
> >Whats the patch sequence to arrive at rc2-git6 please?
> >
> 
> Umm... If I am understanding your question correctly:
> 
> Start with 2.6.14
>     http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
> 
> Apply 2.6.15-rc2
>     http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.15-rc2.bz2
> 
> Apply 2.6.14-rc2-git6
>     
> http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.15-rc2-git6.bz2
> 
> Is this what you're asking???

Gene,
I expect that lots of people use 'ketchup' to keep their kernel
trees up to date (those not using 'git', I mean).
If ketchup isn't to your liking, you could try my grab-kernel-rc
script:
  http://www.xenotime.net/linux/scripts/grab-kernel-rc

I have to run somewhere now, but I can explain it and help you
with it later if you are interested.

---
~Randy
