Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVCUXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVCUXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCUXh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:37:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60302 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262145AbVCUWtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:49:50 -0500
Date: Mon, 21 Mar 2005 23:49:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050321224937.GQ1390@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz> <423F0C67.6000006@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F0C67.6000006@lougher.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Perhaps squashfs is good enough improvement over cramfs... But I'd
> >like those 4Gb limits to go away.
> 
> So would I.  But it is a totally groundless reason to refuse kernel 
> submission because of that, Squashfs users are quite happily using it 
> with such a "terrible" limitation.  I'm asking for Squashfs to be put in 
> the kernel _now_ because users are asking me to do it _now_.  If it 

Putting it into kernel because users want it is... not a good
reason. You should put it there if it is right thing to do. I believe
you should address those endianness issues and drop V1 support. If
breaking 4GB limit does not involve on-disk format change, it may be
okay to merge. After code is merged, doing format changes will be
hard...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
