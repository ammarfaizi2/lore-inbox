Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVAFWac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVAFWac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbVAFWaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:30:20 -0500
Received: from gprs215-35.eurotel.cz ([160.218.215.35]:11400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263033AbVAFW3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:29:42 -0500
Date: Thu, 6 Jan 2005 23:29:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lion Vollnhals <webmaster@schiggl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050106222927.GC25913@elf.ucw.cz>
References: <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org> <20050104214315.GB1520@elf.ucw.cz> <41DC0E70.4000005@schiggl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DC0E70.4000005@schiggl.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a problem with net-devices, ne2000 in particular, in 2.6.9 and 
> 2.6.10, too. After a resume the ne2000-device doesn't work anymore. I 
> have to restart it using the initscripts.
> 
> How do I add suspend/resume support (to ISA devices, like my ne2000)?
> Can you point me to some information/tutorial?

Look how i8042 suspend/resume support is done and do it in similar
way...
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
