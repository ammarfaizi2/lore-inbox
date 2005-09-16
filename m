Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbVIPJye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbVIPJye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbVIPJye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:54:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161149AbVIPJyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:54:33 -0400
Date: Fri, 16 Sep 2005 02:53:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, caphrim007@gmail.com
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
Message-Id: <20050916025356.0d5189a6.akpm@osdl.org>
In-Reply-To: <200509152357.58921.dtor_core@ameritech.net>
References: <432A4A1F.3040308@gmail.com>
	<200509152357.58921.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Thursday 15 September 2005 23:29, Tim Rupp wrote:
> > I just recently went to upgrade to 2.6.13 from 2.6.12.3 and after
> > re-compiling with a clean .config, I've hit a snag.
> > 
> > I'm pretty sure I've got the config script down right, but upon reboot,
> > I no longer have a keyboard.
> > 
> > I checked to see if this had crept up between 2.6.12.3 and 2.6.13.1. It
> > seems that >2.6.13 are the versions that do this.
> > 
> > Attached are dmesgs from my 2.6.13.1 and 2.6.12.3 kernels. In the
> > 2.6.13.1 kernel I noticed this line.
> > 
> > 	i8042.c: Can't read CTR while initializing i8042
> > 
> 
> The kernel failed to talk to your keyboard controller. Try booting with
> "usb-handoff" and also try "acpi=off"
> 

This is of course not an acceptable solution.  A machine which worked
without funky commandline parameters should continue to work in later
kernels.

How come it broke?
