Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267996AbUHLHkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267996AbUHLHkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUHLHkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:40:25 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:20356 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267996AbUHLHkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:40:22 -0400
Date: Thu, 12 Aug 2004 09:40:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: Dax Kelson <dax@gurulabs.com>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040812074002.GC29466@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <1092269309.3948.57.camel@mentorng.gurulabs.com> <1092281393.7765.141.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092281393.7765.141.camel@dhcppc4>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think I'd rather see the calls to usermode deleted
> instead of extended -- unless there is a reason that
> the general event -> acpid method can't work.

See above, switching to acpid would break all the existing
setups... in stable series.

Also notice that thermal.c is so "interestingly" written that my patch
does not actually make it longer by deleting useless defines etc...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
