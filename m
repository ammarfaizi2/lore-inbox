Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286876AbRLWM0T>; Sun, 23 Dec 2001 07:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRLWM0C>; Sun, 23 Dec 2001 07:26:02 -0500
Received: from hermes.domdv.de ([193.102.202.1]:19973 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S286877AbRLWMZl>;
	Sun, 23 Dec 2001 07:25:41 -0500
Message-ID: <XFMail.20011223131241.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1009077742.1677.0.camel@thanatos>
Date: Sun, 23 Dec 2001 13:12:41 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Thomas Hood <jdthood@mail.com>
Subject: Re: APM driver patch summary
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King <rmk@arm.linux.org.uk>,
        Andrej <Andrej.Borsenkow@mow.siemens.ru>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fine with me,
as I always compile APM into the kernel I just didn't see it (mental note to
self: always try module build before submitting).
I'll get the combined patch and test it.

On 23-Dec-2001 Thomas Hood wrote:
> On Sat, 2001-12-22 at 09:44, Andreas Steinmetz wrote:
>> 1. There is now a module parameter apm-idle-threshold which
>> allows to override the compiled in idle percentage threshold
>> above which BIOS idle calls are done.
> 
> Andrej, your patch doesn't work when compiled as a module
> because of a name mismatch.
> 
> I went in and cleaned the patch up a bit.  Now there is only
> one extra parameter, called "idle_threshold", which you can
> set to 100 if you want to disable use of APM BIOS idling.
> 
> I have combined this tweaked idle patch with the
> notification patch and made it available here:
>    http://panopticon.csustan.edu/thood/apm.html
> Patch is against 2.4.17.
> 
> I hope lots of people will test it.  It's working fine for me.
> 
> --
> Thomas Hood
> 
> 
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
