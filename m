Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUJONqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUJONqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUJONpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:45:40 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:28167 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267792AbUJONmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:42:51 -0400
Date: Fri, 15 Oct 2004 13:48:27 +0000
From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
References: <416E6ADC.3007.294DF20D@localhost>
In-Reply-To: <416E6ADC.3007.294DF20D@localhost> (from
	KendallB@scitechsoft.com on Thu Oct 14 21:02:36 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1097848107l.20759l.0l@hh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-10-2004 21:02:36, Kendall Bennett wrote:
> Hello All,
[...]
> So what we would like to find out is how much interest there might be
> in
> both an updated VESA framebuffer console driver as well as the code
> for
> the Video card BOOT process being contributed to the maintstream
> kernel.

The BOOT stuff is very interesting.  Currently, both my videocards
(in the same pc)
have nice hw-specific framebuffer drivers, but they require that
the card is initialized by the bios first and this only ever
happens to one of the cards.  Xfree _can_ do the job, but way
too late for setting up the framebuffer device.

> If there is interest, we would start out by first contributing the
> core
> emulator and Video BOOT code, and then work on building a better VESA
> framebuffer console driver.

Having video BOOT would be great, and please make it independent
of the framebuffer drivers.  I might want to try your vesa driver,
but I might also want to use the hw-accelerated chip specific driver
that happens to need an initialized video card.

Helge Hafting


