Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSGFSZf>; Sat, 6 Jul 2002 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSGFSZe>; Sat, 6 Jul 2002 14:25:34 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:32997 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315734AbSGFSZe>; Sat, 6 Jul 2002 14:25:34 -0400
Date: Sat, 6 Jul 2002 03:14:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: More Fbdev policies.
Message-ID: <20020706011402.GC112@elf.ucw.cz>
References: <Pine.LNX.4.44.0207051302300.30731-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051302300.30731-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Recently I was porting several fbdev drivers over to the new api. Some
> driver writers asked to have the changes reverted. So anyone who wants the
> drivers reverted to the previous state say so. I will revert them. I did
> this not to break any drivers but have a smooth transition. This will not
> be the case now.
> 
> NOTE:
>    I will begin change the upper fbdev layer monday thus breaking most
> if not all drivers. It is up to the maintainers to fix them. If not
> fixed by the end of the developement cycle they will be dropped.

End of development cycle == 2.6.0 or 2.6.20? It would probably make
sense to only mark them broken for stable series, they are pretty
likely to be fixed there.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
