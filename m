Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUJCX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJCX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUJCX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:27:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6925 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268236AbUJCX1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:27:11 -0400
Date: Mon, 4 Oct 2004 01:26:31 +0200
From: Adrian Bunk <adrian.bunk@stusta.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: Norbert Preining <preining@logic.at>, Ed Tomlinson <edt@aei.ca>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-ID: <20041003232631.GV1948@stusta.mhn.de>
References: <200410021440.45194.edt@aei.ca> <1096787657.9182.6.camel@localhost> <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <200410021440.45194.edt@aei.ca> <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <20041002105038.GB2470@stusta.mhn.de> <20041003083014.GB12458@gamma.logic.tuwien.ac.at> <416084A5.4080200@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416084A5.4080200@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 07:00:53PM -0400, Ed Sweetman wrote:
> None of the mails reporting that inserting a header in any file has 
> produced a build here that actually gets rid of the build error.  I have 
> the same errors about implicit declarations of ack_APIC_irq that i had 
> before i added asm/io_apic.h to irq.c in arch/i386/kernel and before i 
> added it to include/asm/hardirq.h.   I've attached my .config to see if 
> anyone realizes what i'm doing wrong or what's not being defined 
> correctly. thanks.

You have to include asm/apic.h in hardirq.h (not asm/io_apic.h).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

