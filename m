Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVA1NEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVA1NEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVA1NEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:04:41 -0500
Received: from gprs212-55.eurotel.cz ([160.218.212.55]:55937 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261321AbVA1NEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:04:39 -0500
Date: Fri, 28 Jan 2005 14:04:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pierre Chifflier <chifflier@cpe.fr>
Cc: kernel list <linux-kernel@vger.kernel.org>, jon.liu@hp.com
Subject: Re: Applications segfault on evo n620c with 2.6.10
Message-ID: <20050128130422.GB7429@elf.ucw.cz>
References: <20050127184334.GA1368@elf.ucw.cz> <20050128101144.GE19970@image4.cpe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128101144.GE19970@image4.cpe.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It happened for 3rd in a week now...
> > 
> > When problem happens, processes start to segfault, usually right
> > during startup. Programs that were loaded prior to problem usualy
> > works, and can be restarted. I also seen sendmail exec failing with
> > "no such file or directory" when it clearly was there. Reboot corrects
> > things, and filesystem (ext3) is not damaged.
> > 
> > Unfortunately I do not know how to reproduce it. I tried
> > parallel-building kernels for few hours and that worked okay. Swsusp
> > is not involved (but usb, bluetooth, acpi and sound may be).
> > 
> > Does anyone else see something similar?
> 
> I have the same laptop and there is no error here.
> However, I remember this laptop was affected by a RAM problem, which
> could cause these symptoms.
> 
> More infos here:
> http://www.theregister.co.uk/2004/06/26/hp_ram_recall/

I see... unfortunately this is some strange kind of engineering sample
:-(, and they are no longer replacing the memory.

Does someone still have the application that tests if the flaw is
present? Is there easy way to tell that from markings on the chip?

"korea 253 PC2100S-25330-Z M470L6423DN0-CB0 512MB DDR PC2100CL2.5"

Some sources report that it only happens with C3 -- and I had usb
plugged in, that should result in no C3... 

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
