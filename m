Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVCVHCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVCVHCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVCVHBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:01:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42668 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262065AbVCUWcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:32:07 -0500
Date: Mon, 21 Mar 2005 23:31:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mws <mws@twisted-brains.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050321223146.GM1390@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <200503211908.46602.mws@twisted-brains.org> <20050321185418.GC1390@elf.ucw.cz> <423F496C.10004@twisted-brains.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F496C.10004@twisted-brains.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>>Well, probably Phillip can answer this better than me, but the main 
> >>>>differences that affect end users (and that is why we are using 
> >>>>SquashFS right now) are:
> >>>>                         CRAMFS          SquashFS
> >>>>
> >>>>Max File Size               16Mb               4Gb
> >>>>Max Filesystem Size        256Mb              4Gb?
> >>>>       
> >>>>
> >>>So we are replacing severely-limited cramfs with also-limited
> >>>squashfs... For live DVDs etc 4Gb filesystem size limit will hurt for
> >>>sure, and 4Gb file size limit will hurt, too. Can those be fixed?
> >>>     
> >>>
> >
> >...
> > 
> >
> >>but if there is a contribution from the outside - it is not taken "as is" 
> >>and maybe fixed up, which
> >>should be nearly possible in the same time like analysing and commenting 
> >>the code - it ends up
> >>in having less supported hardware. 
> >>
> >>imho if a hardware company does indeed provide us with opensource 
> >>drivers, we should take these
> >>things as a gift, not as a "not coding guide a'like" intrusion which
> >>has to be defeated.
> >
> >Remember that horse in Troja? It was a gift, too.

> of course there had been a horse in troja., but thinking like that 
> nowadays is a bit incorrect - don't you agree?
> 
> code is reviewed normally - thats what i told before and i stated as 
> good feature - but there is no serious reason
> to blame every code to have potential "trojan horses" inside and to 
> reject it.

I should have added a smiley.

I'm not seriously suggesting that it contains deliberate problem. But
codestyle uglyness and arbitrary limits may come back and haunt us in
future. Once code is in kernel, it is very hard to change on-disk
format, for example.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
