Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUK1Q7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUK1Q7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUK1Q7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:59:32 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:46977 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261532AbUK1Q64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:58:56 -0500
Date: Sun, 28 Nov 2004 17:58:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [1/6]
Message-ID: <20041128165835.GA1214@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162320.GA28881@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I can not merge anything before 2.6.10. As you have seen, I have quite
a lot of patches in my tree, and I do not want mix them with these...

>  device-tree.diff 
>    base from suspend2 with a little changed.

I do not want this one.

>  core.diff
>   1: redefine struct pbe for using _no_ continuous as pagedir.

Can I get this one as a separate diff?

>   2: make shrink memory as little as possible.
>   3: using a bitmap speed up collide check in page relocating.
>   4: pagecache saving ready.
> 
>  i386.diff
>  ppc.diff
>   i386 and powerpc suspend update.

ppc changes look good, you should send them to ppc maintainer...

>  pagecachs_addon.diff
>   if enable page caches saving, must using it, it making saving
>   pagecaches safe. idea from suspend2.
> 
>   ppcfix.diff
>   fix compile error. 
>   $ gcc -v
>    .... 
>    gcc version 2.95.4 20011002 (Debian prerelease)

Send this one to Andrew Morton, now, it is a bugfix.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
