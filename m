Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRDBXGv>; Mon, 2 Apr 2001 19:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRDBXGo>; Mon, 2 Apr 2001 19:06:44 -0400
Received: from quattro.sventech.com ([205.252.248.110]:33043 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S131481AbRDBXGe>; Mon, 2 Apr 2001 19:06:34 -0400
Date: Mon, 2 Apr 2001 19:05:42 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ketil Froyn <ketil@froyn.com>, linux-kernel@vger.kernel.org
Subject: Re: oops in uhci.c running 2.4.2-ac28
Message-ID: <20010402190541.F17651@sventech.com>
In-Reply-To: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org> <20010402185526.A4083@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010402185526.A4083@devserv.devel.redhat.com>; from Pete Zaitcev on Mon, Apr 02, 2001 at 06:55:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > Date: 	Sun, 1 Apr 2001 03:35:03 +0200 (CEST)
> > From: Ketil Froyn <ketil@froyn.com>
> > To: <linux-kernel@vger.kernel.org>
> 
> > While running kernel 2.4.2-ac28, I switched on spinlock debugging and
> > verbose BUG() reporting (I always use sysrq). Anyway, while running this I
> > got an oops after about 2 or 3 minutes running, several times, exact same
> > place each time, which I traced back to rh_int_timer_do().
> > This was in uhci.c (I used CONFIG_USB_UHCI_ALT).  [...]  I
> > recompiled with usb-uhci.c instead (CONFIG_USB_UHCI), and now I don't get
> > the oops any more.
> 
> I am behind usb-uhci for a reason. Alan bounced your report
> to me but I do not see a case for action...

What do you mean by "behind".

Have you tried the latest patches for uhci.c?

JE

