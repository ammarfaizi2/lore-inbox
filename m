Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUIZKG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUIZKG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUIZKG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:06:29 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19901 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268590AbUIZKG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:06:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sun, 26 Sep 2004 12:08:02 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
References: <200409251214.28743.rjw@sisk.pl> <20040925234045.GA17856@elf.ucw.cz>
In-Reply-To: <20040925234045.GA17856@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409261208.02209.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 01:40, Pavel Machek wrote:
> Hi!
> 
> > I've just tried to suspend my box and I must admit I've given up after 30 
> > minutes (sic!) of waiting when there were only 12% of pages written to 
disk.  
> > Apparently, swsusp slows down to an unacceptable level after saying "PM: 
> > Writing image to disk".
> > 
> > The box is an Athlon 64-based notebook.  The .config is available at:
> > http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3.config
> > and the output of dmesg is available at:
> > http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3-dmesg.log
> 
> We have seen something similar after hdparm was used on specific
> machines. Are you using hdparm?

Not explicitly, but it's used by SuSE initscripts to set IDE DMA, AFAICS.  
However, the problem did not occur on 2.6.9-rc2-mm1 with the same 
initscripts.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
