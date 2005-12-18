Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbVLRCfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVLRCfv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 21:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbVLRCfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 21:35:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:65420 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932670AbVLRCfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 21:35:50 -0500
Date: Sun, 18 Dec 2005 03:35:36 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218023536.GC23384@wotan.suse.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217205238.GR23349@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - "it allows more threads for 32bit which might run out of lowmem" - i
> > think everybody agrees that the 10k threads case is not really
> > something to encourage. And even when you want to add it then only a factor
> > two increase (which this patch brings) is not really too helpful.
> >...
> 
> Unfortunately, "is not really something to encourage" doesn'a make 
> "happens in real-life applications" impossible...

real-life applications can either use user space threads or 64bit
machines. The days when Linux did otherwise unjustificable ha^w^wdesign 
changes just to work around the 900MB lowmem on weird loads on 
extremly big 32bit machines are pretty much over I think... 

-Andi

