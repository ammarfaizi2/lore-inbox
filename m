Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDBW4l>; Mon, 2 Apr 2001 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRDBW4c>; Mon, 2 Apr 2001 18:56:32 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:21380 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131424AbRDBW4X>; Mon, 2 Apr 2001 18:56:23 -0400
Date: Mon, 2 Apr 2001 18:55:26 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ketil Froyn <ketil@froyn.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: oops in uhci.c running 2.4.2-ac28
Message-ID: <20010402185526.A4083@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org>; from ketil@froyn.com on Sun, Apr 01, 2001 at 03:35:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: 	Sun, 1 Apr 2001 03:35:03 +0200 (CEST)
> From: Ketil Froyn <ketil@froyn.com>
> To: <linux-kernel@vger.kernel.org>

> While running kernel 2.4.2-ac28, I switched on spinlock debugging and
> verbose BUG() reporting (I always use sysrq). Anyway, while running this I
> got an oops after about 2 or 3 minutes running, several times, exact same
> place each time, which I traced back to rh_int_timer_do().
> This was in uhci.c (I used CONFIG_USB_UHCI_ALT).  [...]  I
> recompiled with usb-uhci.c instead (CONFIG_USB_UHCI), and now I don't get
> the oops any more.

I am behind usb-uhci for a reason. Alan bounced your report
to me but I do not see a case for action...

-- Pete
