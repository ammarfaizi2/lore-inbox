Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVDCXAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVDCXAC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVDCXAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:00:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20959 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261950AbVDCW7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 18:59:49 -0400
Date: Mon, 4 Apr 2005 00:59:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050403225929.GE13466@elf.ucw.cz>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <20050403224557.GB1015@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403224557.GB1015@gamma.logic.tuwien.ac.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> it is only suspend2ram which stopped working after 2.6.11-mm4 (at least
> in 2.6.12-rc1-mm3,4).
> 
> Concerning tests with minimal kernel config: I guess since it *was*
> working there should not be a change necessary -- but well, from
> 2.6.11-mm2 to 2.6.11-mm4 I had to stop hotplug/usb to get ot working, so
> maybe now I have to stop all the other things. Grrrr. This is not what I
> want!
> 
> Isn't there a different way?

I'd like to fix the problem, but first I need to know where the
problem is.  If it works with minimal config, I know that it is one of
drivers you deselected.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
