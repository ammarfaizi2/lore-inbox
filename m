Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWJ1SxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWJ1SxF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWJ1SxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:53:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51472 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932086AbWJ1SxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:53:01 -0400
Date: Sat, 28 Oct 2006 18:52:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Zeuthen <davidz@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061028185244.GC5152@ucw.cz>
References: <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com> <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com> <1162046193.19446.521.camel@pmac.infradead.org> <1162047338.2723.49.camel@zelda.fubar.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162047338.2723.49.camel@zelda.fubar.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > If it makes enough sense that it's worth exporting it to userspace at
> > all, then it can go into battery.h.
> 
> If it's non-standard please make sure to prefix the name with something
> unique e.g.
> 
>  x_thinkpad_charging_inhibit [1]

> to avoid collisions, e.g. two drivers using the same name but the

You were clearly exposed to harmful dose of smtp.

This is ugly, and unneccessary: kernel is centrally controlled. We
*will* want to merge such attributes into something standard.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
