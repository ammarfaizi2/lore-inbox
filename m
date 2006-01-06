Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWAKMlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWAKMlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWAKMlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:41:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29957 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751194AbWAKMlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:41:14 -0500
Date: Fri, 6 Jan 2006 14:23:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
Message-ID: <20060106142304.GA3269@ucw.cz>
References: <200601061945.09466.lkml@spitalnik.net> <200601071604.03846.lkml@spitalnik.net> <20060106043019.GA2545@ucw.cz> <200601072042.07337.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601072042.07337.lkml@spitalnik.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Well, I was using suspend2.net's page just as reference, to point out the
> > > fact that HIGHMEM is on both suspend "platforms" supported only up to 4G.
> > > I was not refering to suspend2's actual features, but rather swsusp's (or
> > > what's the proper name for suspend1 code). So i guess the patch still
> > > holds, no?
> >
> > No.
> 
> Could you be please more specific? Is there some list of swsusp's features? 
> swsusp.txt says that it "A: It should work okay with highmem." Does that mean 
> both possible highmem configurations?

It should work in all configurations. I'd like to try fixing
it before disabling it in config.

> > s2ram should not depend on ammount of memory. Try debugging
> > it, but do not disable feature just because it does not work
> > for you. I'd start with minimum drivers...
> 
> Well, I've tried it with the bare minimum that was needed to run the system, 
> but it did the same. I'm sorry but i lack the knowledge to properly debug it 
> on source level.  Do you see something that perhaps i don't see in the oops? 
> Maybe some clues as what might be going wrong?

No clues :-(. I'll try reproducing it locally.

-- 
Thanks, Sharp!
