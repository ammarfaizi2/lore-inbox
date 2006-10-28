Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWJ1TuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWJ1TuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWJ1TuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:50:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751354AbWJ1TuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:50:11 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Zeuthen <davidz@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <20061028185244.GC5152@ucw.cz>
References: <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com>
	 <1162046193.19446.521.camel@pmac.infradead.org>
	 <1162047338.2723.49.camel@zelda.fubar.dk>  <20061028185244.GC5152@ucw.cz>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 15:48:54 -0400
Message-Id: <1162064934.2723.77.camel@zelda.fubar.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 18:52 +0000, Pavel Machek wrote:
> You were clearly exposed to harmful dose of smtp.

Actually I got the idea when thinking of .desktop files but whatever.

> This is ugly, and unneccessary: kernel is centrally controlled. We
> *will* want to merge such attributes into something standard.

Uh, such standards don't happen overnight as this thread painfully
demonstrates, i.e. there is not yet any "standard" for handling
batteries until dwmw2 actually stepped up. That alone says something.
And we're at 2.6.19 about 15 years into development of Linux?

You may or may not like it... but battery class drivers will have such
non-standard things. I'm merely suggesting to tag these as non-standard
so it's bloody evident they are non-standard. For the record, I also
think that making non standard attributes ugly will help accelerate us
in standardizing on it. You can also easier grep through the sources to
find offending code when you do decide to standardize it.

Playing the "kernel is centrally controlled" card doesn't work here. Do
not pass start. Do not collect $200. (It works in a helluva lot of other
situations though.)

    David


