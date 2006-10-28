Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWJ1PJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWJ1PJm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWJ1PJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:09:42 -0400
Received: from mx2.redhat.com ([66.187.237.31]:15258 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1750821AbWJ1PJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:09:41 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Zeuthen <davidz@redhat.com>
To: Richard Hughes <hughsient@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <1162041726.16799.1.camel@hughsie-laptop>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 11:09:08 -0400
Message-Id: <1162048148.2723.61.camel@zelda.fubar.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 14:22 +0100, Richard Hughes wrote:
> On Sat, 2006-10-28 at 13:15 +0100, David Woodhouse wrote:
> > 
> > Hm. Again we have the question of whether to export 'threshold_pct'
> > vs.'threshold_abs', or whether to have a separate string property
> > which says what the 'unit' of the threshold is. I don't care much --
> > I'll do whatever DavidZ prefers.
> 
> Unit is easier to process in HAL in my opinion.

What about just prepending the unit to the 'threshold' file? Then user
space can expect the contents of said file to be of the form "%d %s". I
don't think that violates the "only one value per file" sysfs mantra.

    David


