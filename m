Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVCUKSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVCUKSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVCUKSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:18:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31377 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261433AbVCUKSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:18:03 -0500
Date: Mon, 21 Mar 2005 11:14:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Phillip Lougher <phillip@lougher.demon.co.uk>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050321101441.GA23456@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423727BD.7080200@grupopie.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Also, this filesystem seems to do the same thing as cramfs.  We'd need to
> >understand in some detail what advantages squashfs has over cramfs to
> >justify merging it.  Again, that is something which is appropriate to the
> >changelog for patch 1/1.
> 
> Well, probably Phillip can answer this better than me, but the main 
> differences that affect end users (and that is why we are using SquashFS 
> right now) are:
>                           CRAMFS          SquashFS
> 
> Max File Size               16Mb               4Gb
> Max Filesystem Size        256Mb              4Gb?

So we are replacing severely-limited cramfs with also-limited
squashfs... For live DVDs etc 4Gb filesystem size limit will hurt for
sure, and 4Gb file size limit will hurt, too. Can those be fixed?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
