Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVDOJr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVDOJr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 05:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDOJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 05:47:57 -0400
Received: from hermes.domdv.de ([193.102.202.1]:36880 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261787AbVDOJpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 05:45:18 -0400
Message-ID: <425F8CE8.3040200@domdv.de>
Date: Fri, 15 Apr 2005 11:44:08 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz> <20050413233904.GA31174@gondor.apana.org.au> <20050413234602.GA10210@elf.ucw.cz> <20050414003506.GQ25554@waste.org> <20050414065124.GA1357@elf.ucw.cz>
In-Reply-To: <20050414065124.GA1357@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Andreas, do you think you could write nice, long, FAQ entries so that
> we don't have to go through this discussion over and over?

I can do so over the weekend. Am I right that you mean the FAQ section
of Documentation/power/swsusp.txt?

BTW: would it make sense to reset the suspend header via
software_resume() if booted with noresume? Currently this code path does
nothing.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
