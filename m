Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVAYSth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVAYSth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVAYSth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:49:37 -0500
Received: from gprs213-152.eurotel.cz ([160.218.213.152]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262056AbVAYStf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:49:35 -0500
Date: Tue, 25 Jan 2005 19:41:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Brice.Goglin@ens-lyon.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125184139.GA1346@elf.ucw.cz>
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F59A50.1090203@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41F59A50.1090203@ens-lyon.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Andrew Morton a écrit :
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> >
> >
> >- Lots of updates and fixes all over the place.
> >
> >- On my test box there is no flashing cursor on the vga console.  Known 
> >bug,
> >  please don't report it.
> >
> >  Binary searching shows that the bug was introduced by
> >  cleanup-vc-array-access.patch but that patch is, unfortunately,
> > huge.

Heh, on my system, I get no cursor, and no letters, either (this is
vga text console). I *can* see the backgrounds, for example if I run
aumix I see colored blocks... Framebuffer does not seem to work,
either.

Letters are present for a while during boot; not sure what makes them
go away.

> ACPI does not work anymore on my Compaq Evo N600c
> (no thermal zone, no fan, no battery, ...).
> It works great on Linus' 2.6.11-rc2, and (from what I remember)
> it was working on the last -mm releases I tried.

I'd test on N620c, but it is rather hard without video :-(.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
