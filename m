Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVAGWSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVAGWSC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAGWPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:15:16 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:26261 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261653AbVAGWLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:11:07 -0500
Subject: Re: 2.6.10-mm2: swsusp regression
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501071345.39847.rjw@sisk.pl>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <200501070041.43023.rjw@sisk.pl> <20050106234829.GF28777@elf.ucw.cz>
	 <200501071345.39847.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1105135940.2488.39.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 08 Jan 2005 09:12:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-01-07 at 23:45, Rafael J. Wysocki wrote:
> > ..so... could you go through sysdev_register()s, one by one,
> > commenting them to see which one causes the regression? That driver
> > then needs to be fixed.
> > 
> > Go after mtrr and time in first places.
> 
> OK, but it'll take some time.

There's an MTRR fix in the -overloaded ck patches. Perhaps it is what
you're after. (Or perhaps it's already included :>)

http://kem.p.lodz.pl/~peter/cko/fixes/2.6.10-cko1-swsusp_fix.patch

Regards,

Nigel


-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

