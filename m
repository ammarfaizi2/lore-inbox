Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275001AbTHFNBL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275006AbTHFNBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:01:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36741 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S275001AbTHFNBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:01:08 -0400
Date: Wed, 6 Aug 2003 14:57:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before software_resume() (version 2)
Message-ID: <20030806125749.GA6875@openzaurus.ucw.cz>
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr> <1059700691.1750.1.camel@laptop-linux> <20030801103054.9E75F30003B9@mwinf0201.wanadoo.fr> <1059734493.11684.0.camel@laptop-linux> <20030806113045.GB583@elf.ucw.cz> <1060170451.5848.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060170451.5848.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Okay. I hadn't tried it yet. I'll happily take up the barrow for you and
> > > push it to Pavel and Linus with the rest, if you like.
> > 
> > Don't even think about that.
> > 
> > It is not safe to run userspace *before* doing resume. You don't want
> > to see problems this would bring in. Forget it.
> > 			
> so how do you resume from a partition on a device mapper volume?
> 
> (and yes I basically agree with your sentiment though)

I know very little about DM, its very well possible that resume from it is not supported.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

