Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWJ1VKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWJ1VKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWJ1VKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:10:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16064 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964846AbWJ1VKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:10:32 -0400
Date: Sat, 28 Oct 2006 23:10:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Zeuthen <davidz@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061028211008.GB30819@elf.ucw.cz>
References: <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com> <1162046193.19446.521.camel@pmac.infradead.org> <1162047338.2723.49.camel@zelda.fubar.dk> <20061028185244.GC5152@ucw.cz> <1162064934.2723.77.camel@zelda.fubar.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162064934.2723.77.camel@zelda.fubar.dk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-10-28 15:48:54, David Zeuthen wrote:
> On Sat, 2006-10-28 at 18:52 +0000, Pavel Machek wrote:
> > This is ugly, and unneccessary: kernel is centrally controlled. We
> > *will* want to merge such attributes into something standard.
> 
> Uh, such standards don't happen overnight as this thread painfully
> demonstrates, i.e. there is not yet any "standard" for handling
> batteries until dwmw2 actually stepped up. That alone says something.
> And we're at 2.6.19 about 15 years into development of Linux?

And we have sys_open. Not sys_x_ext2_open.

> You may or may not like it... but battery class drivers will have such
> non-standard things. I'm merely suggesting to tag these as non-standard
> so it's bloody evident they are non-standard. For the record, I also
> think that making non standard attributes ugly will help accelerate us
> in standardizing on it. You can also easier grep through the sources to
> find offending code when you do decide to standardize it.

You can simply _not merge offending code in the first place_.

"Lets design it so that stupid things can be grepped for" is stupid,
when we can simply "not allow stupid things to be merged".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
