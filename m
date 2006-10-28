Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752489AbWJ1Ogk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbWJ1Ogk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 10:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbWJ1Ogk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 10:36:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25781 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752489AbWJ1Ogj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 10:36:39 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 15:36:33 +0100
Message-Id: <1162046193.19446.521.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 16:34 +0200, Shem Multinymous wrote:
> * Thou shalt not export any attributes in sysfs except these, and
>     with these units: */
> 
> Drivers *will* want to violate this. For example, the "inhibit
> charging for N minutes" command on ThinkPads seems too arcane to be
> worthy of generalization. I would add a more sensible boolean
> "charging_inhibit" attribute to battery.h, and let the ThinkPad driver
> implement it as well as it can. The driver will then expose a
> non-stadard "charging_inhibit_minutes" attribute to reveal the finer
> level of access to those who care.

If it makes enough sense that it's worth exporting it to userspace at
all, then it can go into battery.h.

-- 
dwmw2

