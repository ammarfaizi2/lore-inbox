Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWEAVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWEAVrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWEAVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:47:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39944 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932279AbWEAVrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:47:14 -0400
Date: Mon, 1 May 2006 23:47:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4a/4] MultiAdmin LSM (LKCS'ed)
Message-ID: <20060501214713.GX3570@stusta.de>
References: <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr> <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr> <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605011801400.32172@yvahk01.tjqt.qr> <20060501164740.GA8995@kroah.com> <Pine.LNX.4.61.0605011941220.3919@yvahk01.tjqt.qr> <20060501180737.GA15184@kroah.com> <Pine.LNX.4.61.0605012217420.32033@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605012217420.32033@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 10:19:14PM +0200, Jan Engelhardt wrote:
> >
> >> >> +static inline int range_intersect_wrt(uid_t, uid_t, uid_t, uid_t);
> >> >
> >> >inline functions don't need definitions like this.
> >> 
> >> If memory serves right, callees mentioned below their callers need a 
> >> prototype.
> >
> >You can't have a inline function with a prototype :)
> 
> Says who? The file is the best example that one can X-].
> (Of course, it requires -funit-at-a-time.)

IOW, you know that your code will not compile in the kernel on i386 with 
gcc 3.3 or 3.4.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

