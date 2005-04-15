Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVDOJsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVDOJsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 05:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDOJsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 05:48:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19646 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261783AbVDOJrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 05:47:55 -0400
Date: Fri, 15 Apr 2005 11:47:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050415094726.GD1763@elf.ucw.cz>
References: <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz> <20050413233904.GA31174@gondor.apana.org.au> <20050413234602.GA10210@elf.ucw.cz> <20050414003506.GQ25554@waste.org> <20050414065124.GA1357@elf.ucw.cz> <425F8CE8.3040200@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F8CE8.3040200@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Andreas, do you think you could write nice, long, FAQ entries so that
> > we don't have to go through this discussion over and over?
> 
> I can do so over the weekend. Am I right that you mean the FAQ section
> of Documentation/power/swsusp.txt?

Yes.

> BTW: would it make sense to reset the suspend header via
> software_resume() if booted with noresume? Currently this code path does
> nothing.

I think distros are already doing it in userland, and I do not want to
add potential failure into "safe" boot path.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
