Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSKTPH5>; Wed, 20 Nov 2002 10:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSKTPH5>; Wed, 20 Nov 2002 10:07:57 -0500
Received: from poup.poupinou.org ([195.101.94.96]:17159 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261302AbSKTPH4>; Wed, 20 Nov 2002 10:07:56 -0500
Date: Wed, 20 Nov 2002 16:11:50 +0100
To: Felix Seeger <seeger@sitewaerts.de>
Cc: Ducrot Bruno <poup@poupinou.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021120151150.GC707@poup.poupinou.org>
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119183054.GA6771@suse.de> <20021120063740.GA707@poup.poupinou.org> <200211201129.19007.seeger@sitewaerts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211201129.19007.seeger@sitewaerts.de>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 11:29:19AM +0100, Felix Seeger wrote:
> Hi,
> 
> I have a sony vaio qr10 and I use the sonypi driver.
> If I boot the screen output will stop during acpi init and the notebook boots 
> (but no screen output). I can use vnc but....
> 
> I think this also happens in 2.4, 2.5 isn't better in this.
> I will try to build the kernel without sonypi (never done that) maybe it 
> helps.
> 

What I mean is that the two seems to conflict.
Compiling with sonypi but without acpi is OK, without sonypi but
with acpi should also be OK, but the two should be not safe because
they use the same io registers in order to ack/clean/enable the same
interrupt.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
