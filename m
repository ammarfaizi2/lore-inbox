Return-Path: <linux-kernel-owner+w=401wt.eu-S1422656AbXAESHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbXAESHu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbXAESHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:07:50 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:41050 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422651AbXAESHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:07:48 -0500
Date: Fri, 5 Jan 2007 19:06:59 +0100
From: Mattia Dongili <malattia@linux.it>
To: Len Brown <lenb@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Stelian Pop <stelian@popies.net>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-ID: <20070105180659.GH13533@inferi.kami.home>
Mail-Followup-To: Len Brown <lenb@kernel.org>,
	Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>,
	Stelian Pop <stelian@popies.net>,
	Ismail Donmez <ismail@pardus.org.tr>,
	Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <1167946596.6816.7.camel@hughsie-laptop> <20070104215810.GE25619@inferi.kami.home> <200701051202.31208.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701051202.31208.lenb@kernel.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 12:02:30PM -0500, Len Brown wrote:
> > > Well, HAL has used it for changing the brightness for the last year or
> > > so: /proc/acpi/sony/brightness
> > > 
> > > Although if you use a new enough HAL (CVS), the laptop will be supported
> > > via the shiny new backlight class.
> > 
> > great, -mm already has the /sys/class/backlight in place for sony_acpi
> > and I suppose the /proc entry can be kept until 2.6.20 is released, i.e.
> > just before pushing things for .21.
> > 
> > Len, would you allow it?
> 
> Sure, no problem.
> Checking it into my tree with /proc/acpi/sony is
> no different than what is in -mm today.
> 
> When we push upstream, however, the /proc/acpi/sony part should be gone,
> or at least scheduled for removal.

I'd rather avoid pushing mainline something already scheduled for
removal. Also, a workaround can eventually be implemented in the
userspace tools using /proc/acpi/sony

[...]
> thanks for stepping forward Mattia,

It's me who should thank :)
Thanks
-- 
mattia
:wq!
