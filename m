Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHHUCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHHUCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHHUCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:02:08 -0400
Received: from gprs214-77.eurotel.cz ([160.218.214.77]:8576 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266242AbUHHUCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:02:06 -0400
Date: Sun, 8 Aug 2004 22:01:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: highmem handling again
Message-ID: <20040808200155.GC556@elf.ucw.cz>
References: <20040808192300.GA659@elf.ucw.cz> <20040808195529.GF22610@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808195529.GF22610@mars.ravnborg.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  		}
> > -	} else
> > +	} else {
> > +		extern int restore_highmem(void);
> > +		restore_highmem();
> 
> Prototype in .h files...

I know, this is proof of concept, only. I do not want another
cross-file reference.
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
