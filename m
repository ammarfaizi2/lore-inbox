Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVALW7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVALW7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVALW7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:59:01 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17798 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261547AbVALW4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:56:51 -0500
Subject: Re: 2.6.10-mm2: swsusp regression [update]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112224641.GP1408@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <200501121951.48102.rjw@sisk.pl> <20050112210147.GJ1408@elf.ucw.cz>
	 <200501122344.20589.rjw@sisk.pl>  <20050112224641.GP1408@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105570703.3490.0.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 13 Jan 2005 09:58:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-01-13 at 09:46, Pavel Machek wrote:
> Hi!
> 
> > > > (for example - the second number is always negative and huge).  Would it 
> > mean 
> > > > that get_cmos_time() needs fixing?
> > > 
> > > get_cmos_time() looks okay, but timer){suspend,resume} looks
> > > hopelessly broken.
> > 
> > Well, why don't we convert them to noops, then, at least temporarily?
> 
> Actually, it was my analysis that was wrong. Did you try Nigel's trick
> with updating wall_jiffies?

That bit's not mine.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

