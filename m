Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUHKJGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUHKJGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHKJGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:06:42 -0400
Received: from gprs214-4.eurotel.cz ([160.218.214.4]:9856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268000AbUHKJGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:06:38 -0400
Date: Wed, 11 Aug 2004 11:06:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: trenn@suse.de, seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040811090622.GC674@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <1092215024.2816.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092215024.2816.8.camel@laptop.fenrus.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch cleans up thermal.c a bit, and adds possibility to react to
> > critical overtemp: it tries to call /sbin/overtemp, and only if that
> > fails calls /sbin/poweroff.
> 
> why not call /sbin/hotplug ????

Because /sbin/hotplug may exist, but may not know how to handle
overtemp. Which would be bad.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
