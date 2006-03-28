Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWC1AuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWC1AuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWC1AuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:50:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932108AbWC1AuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:50:05 -0500
Date: Mon, 27 Mar 2006 16:51:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: mgreer@mvista.com, lm-sensors@lm-sensors.org, r.marek@sh.cvut.cz,
       khali@linux-fr.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85
 chips to m41t00 driver
Message-Id: <20060327165120.35376d11.akpm@osdl.org>
In-Reply-To: <20060328002625.GE21077@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012406.GE9560@mag.az.mvista.com>
	<20060326145840.5e578fa4.akpm@osdl.org>
	<20060328002625.GE21077@mag.az.mvista.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
> Resend...
> ---
> 
>  drivers/i2c/chips/m41t00.c |  294 ++++++++++++++++++++++++++++++++++-----------
>  include/linux/m41t00.h     |   50 +++++++

Not sure what to make of this.  It has no changelog, it doesn't apply on
top of your previous three patches:

rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
rtc-m41t00-driver-cleanup.patch
rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch

and it doesn't apply when used to replace
rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch.

An incremental patch against the three above patches would be ideal...
