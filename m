Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283561AbRLWDW1>; Sat, 22 Dec 2001 22:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLWDWR>; Sat, 22 Dec 2001 22:22:17 -0500
Received: from hermes.toad.net ([162.33.130.251]:40324 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S283288AbRLWDWJ>;
	Sat, 22 Dec 2001 22:22:09 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Borsenkow Andreas Steinmetz <ast@domdv.de>,
        Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        Russell King <rmk@arm.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Dec 2001 22:22:13 -0500
Message-Id: <1009077742.1677.0.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-22 at 09:44, Andreas Steinmetz wrote:
> 1. There is now a module parameter apm-idle-threshold which
> allows to override the compiled in idle percentage threshold
> above which BIOS idle calls are done.

Andrej, your patch doesn't work when compiled as a module
because of a name mismatch.

I went in and cleaned the patch up a bit.  Now there is only
one extra parameter, called "idle_threshold", which you can
set to 100 if you want to disable use of APM BIOS idling.

I have combined this tweaked idle patch with the
notification patch and made it available here:
   http://panopticon.csustan.edu/thood/apm.html
Patch is against 2.4.17.

I hope lots of people will test it.  It's working fine for me.

--
Thomas Hood


