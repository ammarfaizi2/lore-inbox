Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWGEXPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWGEXPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWGEXPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:15:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965040AbWGEXPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:15:09 -0400
Date: Thu, 6 Jul 2006 01:15:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705231508.GM26941@stusta.de>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <20060705145826.fc549c7f.rdunlap@xenotime.net> <20060705220009.GB32040@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705220009.GB32040@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 12:00:09AM +0200, Ingo Molnar wrote:
> 
> * Randy.Dunlap <rdunlap@xenotime.net> wrote:
> 
> > > well, the allnoconfig thing is artificial (and the uninteresting) for a 
> > > number of reasons:
> > 
> > hm, I'd have to say that allyesconfig is also artificial and the 
> > savings numbers are somewhat uninteresting in that case too.
> 
> well the 'allyesconfig' isnt the true allyesconfig but one with most 
> debugging options disabled. It is quite close to a typical distro config 
> - hence very much relevant. (I wanted to use something that is easy to 
> reproduce.) Believe me, for large configs the savings are real.

What is the difference between "most debugging options disabled" and
"all debugging options disabled"?

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

