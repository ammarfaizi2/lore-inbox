Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVAKDTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVAKDTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAKDQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:16:41 -0500
Received: from gprs215-170.eurotel.cz ([160.218.215.170]:897 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262557AbVAKDPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:15:32 -0500
Date: Tue, 11 Jan 2005 04:15:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org, xhejtman@mail.muni.cz
Subject: Re: software suspend patch [1/6]
Message-ID: <20050111031520.GB4092@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com> <20041128165835.GA1214@elf.ucw.cz> <20041129154307.GC4616@hugang.soulinfo.com> <20050109224325.GE1353@elf.ucw.cz> <20050111020112.GB22398@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111020112.GB22398@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you have any updates? It would be nice to separate non-continuous
> > pagedir from speeding up check_pagedir?
> > 
> > ...plus check_pagedir should really use PageNosaveFree flag instead of
> > allocating there own (big!) bitmaps. It should also make the code
> > simpler...
> 
> I'm very happy with current swsusp, that's stable for me. 
>  2.6.10-mm1 + ppc patch from 
>   http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
>  + your free some memory patch
> 
> I using it for a week, never failed, never oops. :)
> 
> The only problem is relocating a little slowly.

I just got very nice patch from Lukas Hejtmanek to relocate
faster... It would be great if you could test it.

> Now I don't think non-continuous pagedir is really need. Anyway I'll
> prepare a patch to make swsusp using non-continuous pagedir.

Thanks.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
