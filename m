Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVCDXwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVCDXwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVCDXrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:47:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26636 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263333AbVCDWbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:31:14 -0500
Date: Fri, 4 Mar 2005 23:31:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304223109.GK3327@stusta.de>
References: <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de> <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org> <4228B514.4020704@keyaccess.nl> <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:37:05PM -0800, Linus Torvalds wrote:
>...
> I used to do "-pre", a long time ago. Exactly because they were 
> synchronization points for developers.
>...
> So the point of -pre's are gone. Have people actually _looked_ at the -rc
> releases? They are very much done when I reach the point and say "ok,
> let's calm down". The first one is usually pretty big and often needs some
> fixing, simply because the first one is _inevitably_ (and by design) the
> one that gets the pent-up demand from the previous calming down period. 
> 
> But it's very much a call to "ok, guys, calm down now".

My impression about your releases is that -rc1 is a first snapshot, but 
there are still invasive changes until -rc3 or -rc4 when you _really_ 
say "only obvious bug fixes will be accepted".

It's _only about naming_:

Name the first one -pre1 instead of -rc1 and the snapshot you announce 
with "only obvious bug fixes will be accepted" -rc1.

It might not matter for you how it's called, but it does matter for 
other people and it doesn't cost you any extra effort.

> And if you aren't calming down, it's _your_ problem. Complaining about 
> naming of -pre vs -rc is pointless. 
>...

If I send a non-bugfix patch to Marcelo after 2.4.30-rc1 he'll say:
  "Thanks, queued for 2.4.31 ."

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

