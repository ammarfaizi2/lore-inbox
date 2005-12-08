Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVLHU4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVLHU4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLHU4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:56:17 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:43788 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751059AbVLHU4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:56:16 -0500
Date: Thu, 8 Dec 2005 21:58:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple
 prototype
Message-Id: <20051208215815.3d001dab.khali@linux-fr.org>
In-Reply-To: <20051207232105.GO6793@flint.arm.linux.org.uk>
References: <20051205202707.GH15201@flint.arm.linux.org.uk>
	<200512070105.40169.dtor_core@ameritech.net>
	<d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	<20051207180842.GG6793@flint.arm.linux.org.uk>
	<d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	<20051207190352.GI6793@flint.arm.linux.org.uk>
	<d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
	<20051207225126.GA648@kroah.com>
	<d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
	<20051207230615.GB742@kroah.com>
	<20051207232105.GO6793@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> On Wed, Dec 07, 2005 at 03:06:15PM -0800, Greg KH wrote:
> > Ok, that's fine with me.  Russell, any objections?
> 
> None what so ever - that's mostly what I envisioned with the patch
> with the _del method.  However, I didn't have an existing user for it.

Do you mean you have the code already? If it is so, could you please
provide a patch Dmitry and I can give a try to?

If not, I am willing to give it a try, if you provide some guidance. I
think I understand that platform_device_del would be the first half of
platform_device_unregister, but do we then want to rebuild
platform_device_unregister on top of platform_device_del so as to avoid
code duplication, or not?

Thanks,
-- 
Jean Delvare
