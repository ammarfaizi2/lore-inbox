Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWC3SYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWC3SYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWC3SYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:24:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58632 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751357AbWC3SYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:24:49 -0500
Date: Wed, 29 Mar 2006 00:30:13 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ashok Raj <ashok.raj@intel.com>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060329003012.GC2762@ucw.cz>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329154748.A12897@unix-os.sc.intel.com> <20060330084153.GC8485@elf.ucw.cz> <200603301817.37315.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603301817.37315.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I thought Rafael cced Pavel during that exchange, maybe i missed.
> 
> I did, but Pavel was travelling at that time (I think).

Yes, I was cc-ed, but only watching discussion by single eye...

> FUrther, the whole problem, as far as I can understand it, is i386-specific,
> so it should be resolved in the i386 architecture config rather than anywhere
> else.

Or maybe in i386 .c files :-). Could we just switch to BIGSMP mode by
default? Intel claims it has no performance disadvatage, and distros
want suspend, anyway...
								Pavel
-- 
Thanks, Sharp!
