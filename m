Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVAHJ4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVAHJ4h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVAHJzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:55:35 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:59358 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261829AbVAHJzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:55:11 -0500
Subject: Re: 2.6.10-mm2: swsusp regression [update]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501081049.02862.rjw@sisk.pl>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <1105135940.2488.39.camel@desktop.cunninghams>
	 <200501080156.06145.rjw@sisk.pl>  <200501081049.02862.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1105178186.5478.57.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 08 Jan 2005 20:56:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-01-08 at 20:49, Rafael J. Wysocki wrote:
> The regression is caused by the timer driver.  Obviously, turning 
> timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go away.
> 
> It looks like a locking problem to me.  I'll try to find a fix, although 
> someone who knows more about these things would probably do it faster. :-)

Can I get you to take a look at the patches I just posted; they might
need some more work for x86_64, but may be helpful.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

