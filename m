Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUJWRst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUJWRst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUJWRst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:48:49 -0400
Received: from gprs212-206.eurotel.cz ([160.218.212.206]:4480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261256AbUJWRss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:48:48 -0400
Date: Sat, 23 Oct 2004 19:48:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET reenabling after suspend-resume
Message-ID: <20041023174833.GA1044@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60032881C6@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60032881C6@scsmsx403.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> hpet hardware seems to need a little prodding during resume 
> >for it to start 
> >> sending the timer interupts again. Attached patch does it 
> >for both i386 
> >> and x86_64.
> >
> >Hmm, what HPET hardware? It must have worked on some machines already,
> >otherwise suspend/resume would have never worked on many AMD x86-64 
> >machines. 

Well, swsusp could work by accident and S3 is was not getting too much
testing...

Patch is quite long, but looks ok to me.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
