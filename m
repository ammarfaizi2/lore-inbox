Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWBTUnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWBTUnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWBTUnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:43:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161174AbWBTUnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:43:05 -0500
Date: Mon, 20 Feb 2006 12:41:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: MIke Galbraith <efault@gmx.de>
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Message-Id: <20060220124122.1a38a065.akpm@osdl.org>
In-Reply-To: <1140449123.7563.2.camel@homer>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43F9DB1D.4090305@aitel.hist.no>
	<1140449123.7563.2.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIke Galbraith <efault@gmx.de> wrote:
>
> On Mon, 2006-02-20 at 16:07 +0100, Helge Hafting wrote:
>  > pentium IV single processor, gcc (GCC) 4.0.3 20060128
>  > 
>  > During boot, I normally get:
>  > parport0: irq 7 detected
>  > lp0: using parport0 (polling).
>  > 
>  > Instead, I got this, written by hand:
> 
>  ........
> 
>  > This oops is simplified. I can get the exact text if
>  > that really matters.  It is much more to write down and
>  > I don't usually have my camera at work.
> 
>  I get the same, and already have the serial console hooked up.
> 
>  BUG: unable to handle kernel NULL pointer dereference at virtual address 000000e8

Thanks.  Could someone try reverting
register-sysfs-device-for-lp-devices.patch?
